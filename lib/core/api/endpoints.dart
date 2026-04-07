import 'dart:typed_data';
import 'api_client.dart';
import '../models/user.dart';
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/dashboard.dart';
import '../models/paginated.dart';
import '../models/scan_result.dart';
import '../models/expense.dart';
import '../models/supplier.dart';
import '../models/purchase.dart';

class Endpoints {
  final ApiClient _api;

  Endpoints(this._api);

  // ---- Auth ----

  Future<LoginResponse> login(String email, String password) async {
    final res = await _api.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return LoginResponse.fromJson(res.data);
  }

  Future<RefreshResponse> refresh(String refreshToken) async {
    final res = await _api.post('/auth/refresh', data: {
      'refreshToken': refreshToken,
    });
    return RefreshResponse.fromJson(res.data);
  }

  Future<void> logout(String refreshToken) async {
    await _api.post('/auth/logout', data: {
      'refreshToken': refreshToken,
    });
  }

  Future<SwitchCompanyResponse> switchCompany(int companyId) async {
    final res = await _api.post('/auth/switch-company', data: {
      'companyId': companyId,
    });
    return SwitchCompanyResponse.fromJson(res.data);
  }

  // ---- Dashboard ----

  Future<DashboardSummary> getDashboardSummary() async {
    final res = await _api.get('/dashboard/summary');
    return DashboardSummary.fromJson(res.data);
  }

  // ---- Clients ----

  Future<PaginatedResponse<Client>> getClients({
    int limit = 50,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get('/clients', queryParams: {
      'limit': limit,
      'offset': offset,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    return PaginatedResponse.fromJson(res.data, Client.fromJson);
  }

  Future<Client> getClient(int id) async {
    final res = await _api.get('/clients/$id');
    return Client.fromJson(res.data);
  }

  // ---- Invoices ----

  Future<PaginatedResponse<InvoiceListItem>> getInvoices({
    int limit = 50,
    int offset = 0,
    String? status,
    int? clientId,
    String? from,
    String? to,
  }) async {
    final res = await _api.get('/invoices', queryParams: {
      'limit': limit,
      'offset': offset,
      if (status != null && status.isNotEmpty) 'status': status,
      if (clientId != null) 'clientId': clientId,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    });
    return PaginatedResponse.fromJson(res.data, InvoiceListItem.fromJson);
  }

  Future<InvoiceDetail> getInvoice(int id) async {
    final res = await _api.get('/invoices/$id');
    return InvoiceDetail.fromJson(res.data);
  }

  // ---- PDF ----

  Future<void> downloadPdf(int invoiceId, String savePath) async {
    await _api.download('/invoices/$invoiceId/pdf', savePath);
  }

  // ---- Receipt OCR ----

  Future<ScanResult> scanReceipt({
    required Uint8List imageBytes,
    required String fileName,
    required String mimeType,
  }) async {
    final res = await _api.postMultipart(
      '/receipts/scan',
      fileBytes: imageBytes,
      fileName: fileName,
      mimeType: mimeType,
    );
    return ScanResult.fromJson(res.data as Map<String, dynamic>);
  }

  Future<InvoiceCreatedResponse> confirmScan(
      SupplierInvoiceConfirmPayload payload) async {
    final res = await _api.post('/receipts/confirm', data: payload.toJson());
    return InvoiceCreatedResponse.fromJson(res.data);
  }

  Future<List<SupplierMatch>> lookupSupplier({String? taxId, String? name}) async {
    final res = await _api.get('/suppliers/lookup', queryParams: {
      if (taxId != null && taxId.isNotEmpty) 'taxId': taxId,
      if (name != null && name.isNotEmpty) 'name': name,
    });
    final list = res.data as List<dynamic>;
    return list.map((e) => SupplierMatch.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>> createSupplier(
      Map<String, dynamic> supplierData) async {
    final res = await _api.post('/suppliers', data: supplierData);
    return res.data as Map<String, dynamic>;
  }

  // ---- Purchases ----

  Future<PaginatedResponse<PurchaseListItem>> getPurchases({
    int limit = 50,
    int offset = 0,
    String? status,
  }) async {
    final res = await _api.get('/purchases', queryParams: {
      'limit': limit,
      'offset': offset,
      if (status != null && status.isNotEmpty) 'status': status,
    });
    return PaginatedResponse.fromJson(res.data, PurchaseListItem.fromJson);
  }
}
