import 'dart:typed_data';
import 'api_client.dart';
import '../models/user.dart';
import '../models/user_permissions.dart';
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/dashboard.dart';
import '../models/paginated.dart';
import '../models/scan_result.dart';
import '../models/expense.dart';
import '../models/supplier.dart';
import '../models/purchase.dart';
import '../models/product.dart';
import '../models/service.dart';
import '../models/tax_return.dart';
import '../models/catalog.dart';
import '../models/budget.dart';
import '../models/sale.dart';

class Endpoints {
  final ApiClient _api;

  Endpoints(this._api);

  // ---- Auth ----

  Future<LoginResponse> login(String email, String password) async {
    final res = await _api.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
        'tenant':
            _api.tenant, // multi-DB: enruta a la base de datos del cliente
      },
    );
    return LoginResponse.fromJson(res.data);
  }

  Future<RefreshResponse> refresh(String refreshToken) async {
    final res = await _api.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken, 'tenant': _api.tenant},
    );
    return RefreshResponse.fromJson(res.data);
  }

  Future<void> logout(String refreshToken) async {
    await _api.post('/auth/logout', data: {'refreshToken': refreshToken});
  }

  Future<SwitchCompanyResponse> switchCompany(int companyId) async {
    final res = await _api.post(
      '/auth/switch-company',
      data: {'companyId': companyId},
    );
    return SwitchCompanyResponse.fromJson(res.data);
  }

  /// Returns enabled module names for the current user's company.
  Future<List<String>> getEnabledModules() async {
    final res = await _api.get('/me/capabilities');
    final data = res.data as Map<String, dynamic>;
    return List<String>.from(data['modules'] as List? ?? []);
  }

  // ---- Dashboard ----

  Future<DashboardSummary> getDashboardSummary() async {
    final res = await _api.get('/dashboard/summary');
    return DashboardSummary.fromJson(res.data);
  }

  Future<MobileDashboardSummary> getMobileDashboard({
    String? from,
    String? to,
  }) async {
    final res = await _api.get(
      '/dashboard/mobile',
      queryParams: {
        if (from != null && from.isNotEmpty) 'from': from,
        if (to != null && to.isNotEmpty) 'to': to,
      },
    );
    return MobileDashboardSummary.fromJson(res.data as Map<String, dynamic>);
  }

  // ---- Clients ----

  Future<PaginatedResponse<Client>> getClients({
    int limit = 50,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/clients',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return PaginatedResponse.fromJson(res.data, Client.fromJson);
  }

  Future<Client> getClient(int id) async {
    final res = await _api.get('/clients/$id');
    return Client.fromJson(res.data);
  }

  Future<Client> createClient(Map<String, dynamic> data) async {
    final res = await _api.post('/clients', data: data);
    return Client.fromJson(res.data);
  }

  Future<Client> updateClient(int id, Map<String, dynamic> data) async {
    final res = await _api.put('/clients/$id', data: data);
    return Client.fromJson(res.data);
  }

  Future<void> patchClientLocation(
    int id,
    double latitude,
    double longitude,
  ) async {
    await _api.patch(
      '/clients/$id/location',
      data: {'latitude': latitude, 'longitude': longitude},
    );
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
    final res = await _api.get(
      '/invoices',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (status != null && status.isNotEmpty) 'status': status,
        'clientId': ?clientId,
        'from': ?from,
        'to': ?to,
      },
    );
    return PaginatedResponse.fromJson(res.data, InvoiceListItem.fromJson);
  }

  Future<InvoiceDetail> getInvoice(int id) async {
    final res = await _api.get('/invoices/$id');
    return InvoiceDetail.fromJson(res.data);
  }

  Future<Map<String, dynamic>> createInvoice(Map<String, dynamic> data) async {
    final res = await _api.post('/invoices', data: data);
    return res.data as Map<String, dynamic>;
  }

  /// Draft -> confirmed (consumes stock server-side).
  Future<Map<String, dynamic>> confirmInvoice(int id) async {
    final res = await _api.post('/invoices/$id/confirm');
    return res.data as Map<String, dynamic>;
  }

  /// Confirmed -> final. Server assigns the legal series number and locks it.
  Future<Map<String, dynamic>> finalizeInvoice(int id) async {
    final res = await _api.post('/invoices/$id/finalize');
    return res.data as Map<String, dynamic>;
  }

  /// Draft/confirmed -> canceled. Restores consumed stock server-side. A final
  /// (issued) invoice cannot be canceled here (the API returns 409 — cancel it on
  /// desktop so the AEAT annulment is declared).
  Future<Map<String, dynamic>> cancelInvoice(int id) async {
    final res = await _api.post('/invoices/$id/cancel');
    return res.data as Map<String, dynamic>;
  }

  /// Edit DRAFT content (lines/issuedAt/notes/taxKind). Returns invoice detail.
  /// 409 if final/confirmed/canceled, paid, or sale-linked.
  Future<Map<String, dynamic>> updateInvoiceContent(
    int id,
    Map<String, dynamic> body,
  ) async {
    final res = await _api.patch('/invoices/$id', data: body);
    return res.data as Map<String, dynamic>;
  }

  /// Edit the private internal notes (allowed in any status).
  Future<Map<String, dynamic>> updateInvoiceInternalNotes(
    int id, {
    String? internalNotes,
  }) async {
    final res = await _api.patch(
      '/invoices/$id/internal-notes',
      data: {'internalNotes': internalNotes},
    );
    return res.data as Map<String, dynamic>;
  }

  /// Register a payment against an invoice. Server-validated: only on a
  /// confirmed/final invoice and never above the pending amount.
  Future<Map<String, dynamic>> createPayment(
    int invoiceId,
    Map<String, dynamic> data,
  ) async {
    final res = await _api.post('/invoices/$invoiceId/payments', data: data);
    return res.data as Map<String, dynamic>;
  }

  // ---- Budgets (Presupuestos) ----

  Future<PaginatedResponse<BudgetListItem>> getBudgets({
    int limit = 50,
    int offset = 0,
    String? status,
    int? clientId,
    String? from,
    String? to,
  }) async {
    final res = await _api.get(
      '/budgets',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (status != null && status.isNotEmpty) 'status': status,
        'clientId': ?clientId,
        'from': ?from,
        'to': ?to,
      },
    );
    return PaginatedResponse.fromJson(res.data, BudgetListItem.fromJson);
  }

  Future<BudgetDetail> getBudget(int id) async {
    final res = await _api.get('/budgets/$id');
    return BudgetDetail.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> createBudget(Map<String, dynamic> data) async {
    final res = await _api.post('/budgets', data: data);
    return res.data as Map<String, dynamic>;
  }

  /// quoteStatus pending -> accepted (idempotent).
  Future<Map<String, dynamic>> acceptBudget(int id) async {
    final res = await _api.post('/budgets/$id/accept');
    return res.data as Map<String, dynamic>;
  }

  /// quoteStatus -> rejected (releases stock reservations).
  Future<Map<String, dynamic>> rejectBudget(int id) async {
    final res = await _api.post('/budgets/$id/reject');
    return res.data as Map<String, dynamic>;
  }

  // ---- Sales (Ventas) ----

  Future<PaginatedResponse<SaleListItem>> getSales({
    int limit = 50,
    int offset = 0,
    String? status,
    int? clientId,
    String? from,
    String? to,
  }) async {
    final res = await _api.get(
      '/sales',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (status != null && status.isNotEmpty) 'status': status,
        'clientId': ?clientId,
        'from': ?from,
        'to': ?to,
      },
    );
    return PaginatedResponse.fromJson(res.data, SaleListItem.fromJson);
  }

  Future<SaleDetail> getSale(int id) async {
    final res = await _api.get('/sales/$id');
    return SaleDetail.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<AvailableBudget>> getAvailableBudgets(int clientId) async {
    final res = await _api.get(
      '/sales/available-budgets',
      queryParams: {'clientId': clientId},
    );
    final raw = (res.data as Map<String, dynamic>)['items'] as List;
    return raw
        .map((e) => AvailableBudget.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<SaleDetail> createSale(Map<String, dynamic> data) async {
    final res = await _api.post('/sales', data: data);
    return SaleDetail.fromJson(res.data as Map<String, dynamic>);
  }

  /// Returns { invoice: {...}, sale: SaleDetail }.
  Future<Map<String, dynamic>> createInvoiceFromSale(
    int saleId,
    Map<String, dynamic> data,
  ) async {
    final res = await _api.post('/sales/$saleId/invoice', data: data);
    return res.data as Map<String, dynamic>;
  }

  // ---- Catalog ----

  Future<PaginatedResponse<Product>> getProducts({
    int limit = 100,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/products',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return PaginatedResponse.fromJson(res.data, Product.fromJson);
  }

  Future<PaginatedResponse<Service>> getServices({
    int limit = 100,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/services',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return PaginatedResponse.fromJson(res.data, Service.fromJson);
  }

  // ---- Company ----

  Future<Map<String, dynamic>> getCompanySettings() async {
    final res = await _api.get('/company');
    return res.data as Map<String, dynamic>;
  }

  Future<Uint8List?> getCompanyLogo() async {
    try {
      return await _api.getBytes('/company/logo');
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> uploadCompanyLogo({
    required Uint8List imageBytes,
    required String mimeType,
  }) async {
    final ext = mimeType == 'image/png'
        ? 'logo.png'
        : mimeType == 'image/webp'
        ? 'logo.webp'
        : 'logo.jpg';
    final res = await _api.postMultipart(
      '/company/logo',
      fileBytes: imageBytes,
      fileName: ext,
      mimeType: mimeType,
    );
    return res.data as Map<String, dynamic>;
  }

  // ---- Users (superadmin) ----

  Future<List<UserWithPermissions>> getUsers() async {
    final res = await _api.get('/users');
    final list = res.data as List<dynamic>;
    return list
        .map((e) => UserWithPermissions.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserWithPermissions> getUserPermissions(int userId) async {
    final res = await _api.get('/users/$userId');
    return UserWithPermissions.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserWithPermissions> updateUserPermissions(
    int userId,
    List<String> permissions,
  ) async {
    final res = await _api.put(
      '/users/$userId/permissions',
      data: {'permissions': permissions},
    );
    return UserWithPermissions.fromJson(res.data as Map<String, dynamic>);
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
    return scanReceiptPages([
      MultipartUploadFile(
        bytes: imageBytes,
        fileName: fileName,
        mimeType: mimeType,
      ),
    ]);
  }

  Future<ScanResult> scanReceiptPages(List<MultipartUploadFile> pages) async {
    if (pages.length > 1) {
      final multiRes = await _api.postMultipartFiles(
        '/receipts/scan',
        files: pages,
      );
      return ScanResult.fromJson(multiRes.data as Map<String, dynamic>);
    }
    final res = await _api.postMultipart(
      '/receipts/scan',
      fileBytes: pages.first.bytes,
      fileName: pages.first.fileName,
      mimeType: pages.first.mimeType,
    );
    return ScanResult.fromJson(res.data as Map<String, dynamic>);
  }

  Future<InvoiceCreatedResponse> confirmScan(
    SupplierInvoiceConfirmPayload payload,
  ) async {
    final res = await _api.post('/receipts/confirm', data: payload.toJson());
    return InvoiceCreatedResponse.fromJson(res.data);
  }

  Future<List<SupplierMatch>> lookupSupplier({
    String? taxId,
    String? name,
  }) async {
    final res = await _api.get(
      '/suppliers/lookup',
      queryParams: {
        if (taxId != null && taxId.isNotEmpty) 'taxId': taxId,
        if (name != null && name.isNotEmpty) 'name': name,
      },
    );
    final list = res.data as List<dynamic>;
    return list
        .map((e) => SupplierMatch.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PaginatedResponse<Supplier>> getSuppliers({
    int limit = 50,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/suppliers',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return PaginatedResponse.fromJson(
      res.data as Map<String, dynamic>,
      Supplier.fromJson,
    );
  }

  Future<Supplier> getSupplier(int id) async {
    final res = await _api.get('/suppliers/$id');
    return Supplier.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Supplier> createSupplier(Map<String, dynamic> supplierData) async {
    final res = await _api.post('/suppliers', data: supplierData);
    return Supplier.fromJson(res.data as Map<String, dynamic>);
  }

  Future<Supplier> updateSupplier(
    int id,
    Map<String, dynamic> supplierData,
  ) async {
    final res = await _api.put('/suppliers/$id', data: supplierData);
    return Supplier.fromJson(res.data as Map<String, dynamic>);
  }

  // ---- Purchases ----

  Future<PaginatedResponse<PurchaseListItem>> getPurchases({
    int limit = 50,
    int offset = 0,
    String? status,
  }) async {
    final res = await _api.get(
      '/purchases',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (status != null && status.isNotEmpty) 'status': status,
      },
    );
    return PaginatedResponse.fromJson(res.data, PurchaseListItem.fromJson);
  }

  Future<PurchaseDetail> getPurchase(int id) async {
    final res = await _api.get('/purchases/$id');
    return PurchaseDetail.fromJson(res.data as Map<String, dynamic>);
  }

  Future<PurchaseDetail> updatePurchase(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await _api.patch('/purchases/$id', data: data);
    return PurchaseDetail.fromJson(res.data as Map<String, dynamic>);
  }

  // ---- Tax returns ----

  Future<TaxReturnListResponse> getTaxReturns({
    int limit = 80,
    int offset = 0,
    String? model,
    int? year,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{'limit': limit, 'offset': offset};
    if (model != null && model.isNotEmpty) queryParams['model'] = model;
    if (year != null) queryParams['year'] = year;
    if (status != null && status.isNotEmpty) queryParams['status'] = status;

    final res = await _api.get('/tax/returns', queryParams: queryParams);
    return TaxReturnListResponse.fromJson(res.data as Map<String, dynamic>);
  }

  // ---- Catalog: Products ----

  Future<List<CatalogProduct>> getCatalogProducts({
    int limit = 50,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/products',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    final data = res.data;
    final raw = data is Map<String, dynamic>
        ? data['items'] as List
        : data as List;
    return raw
        .map((e) => CatalogProduct.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<CatalogProduct> getCatalogProduct(int id) async {
    final res = await _api.get('/products/$id');
    return CatalogProduct.fromJson(res.data as Map<String, dynamic>);
  }

  Future<CatalogProduct> createCatalogProduct(Map<String, dynamic> data) async {
    final res = await _api.post('/products', data: data);
    return CatalogProduct.fromJson(res.data as Map<String, dynamic>);
  }

  Future<CatalogProduct> updateCatalogProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await _api.put('/products/$id', data: data);
    return CatalogProduct.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteCatalogProduct(int id) async {
    await _api.delete('/products/$id');
  }

  // ---- Catalog: Services ----

  Future<List<CatalogService>> getCatalogServices({
    int limit = 50,
    int offset = 0,
    String? search,
  }) async {
    final res = await _api.get(
      '/services',
      queryParams: {
        'limit': limit,
        'offset': offset,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    final svcData = res.data;
    final svcRaw = svcData is Map<String, dynamic>
        ? svcData['items'] as List
        : svcData as List;
    return svcRaw
        .map((e) => CatalogService.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<CatalogService> createCatalogService(Map<String, dynamic> data) async {
    final res = await _api.post('/services', data: data);
    return CatalogService.fromJson(res.data as Map<String, dynamic>);
  }

  Future<CatalogService> updateCatalogService(
    int id,
    Map<String, dynamic> data,
  ) async {
    final res = await _api.put('/services/$id', data: data);
    return CatalogService.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> deleteCatalogService(int id) async {
    await _api.delete('/services/$id');
  }

  // ---- Inventory ----

  Future<List<InventoryMovement>> getInventoryMovements(int productId) async {
    final res = await _api.get('/inventory/movements/$productId');
    return (res.data as List)
        .map((e) => InventoryMovement.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createInventoryEntry({
    required int productId,
    required int quantity,
    required double unitCost,
    String? notes,
  }) async {
    await _api.post(
      '/inventory/entries',
      data: {
        'productId': productId,
        'quantity': quantity,
        'unitCost': unitCost,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      },
    );
  }

  Future<void> adjustInventory({
    required int productId,
    required int delta,
    String? reason,
  }) async {
    await _api.post(
      '/inventory/adjust',
      data: {
        'productId': productId,
        'delta': delta,
        if (reason != null && reason.isNotEmpty) 'reason': reason,
      },
    );
  }
}
