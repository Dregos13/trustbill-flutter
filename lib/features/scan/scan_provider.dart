import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/scan_result.dart';
import '../../core/models/expense.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/utils/error_messages.dart';

enum ScanType { expense, invoice }

/// Holds the current scan result and image bytes while the user reviews.
class ScanState {
  final ScanType scanType;
  final ScanResult? result;
  final Uint8List? imageBytes;
  final String? imageMimeType;
  final bool isScanning;
  final bool isConfirming;
  final String? error;
  final InvoiceCreatedResponse? confirmed;

  const ScanState({
    this.scanType = ScanType.expense,
    this.result,
    this.imageBytes,
    this.imageMimeType,
    this.isScanning = false,
    this.isConfirming = false,
    this.error,
    this.confirmed,
  });

  ScanState copyWith({
    ScanType? scanType,
    ScanResult? result,
    Uint8List? imageBytes,
    String? imageMimeType,
    bool? isScanning,
    bool? isConfirming,
    String? error,
    InvoiceCreatedResponse? confirmed,
  }) {
    return ScanState(
      scanType: scanType ?? this.scanType,
      result: result ?? this.result,
      imageBytes: imageBytes ?? this.imageBytes,
      imageMimeType: imageMimeType ?? this.imageMimeType,
      isScanning: isScanning ?? this.isScanning,
      isConfirming: isConfirming ?? this.isConfirming,
      error: error,
      confirmed: confirmed,
    );
  }
}

class ScanNotifier extends Notifier<ScanState> {
  @override
  ScanState build() => const ScanState();

  void setScanType(ScanType type) {
    state = ScanState(scanType: type);
  }

  Future<void> scanImage(Uint8List bytes, String mimeType) async {
    state = ScanState(
      scanType: state.scanType,
      imageBytes: bytes,
      imageMimeType: mimeType,
      isScanning: true,
    );

    try {
      final endpoints = ref.read(endpointsProvider);
      final result = await endpoints.scanReceipt(
        imageBytes: bytes,
        fileName: 'receipt.${mimeType == 'image/png' ? 'png' : 'jpg'}',
        mimeType: mimeType,
      );
      state = state.copyWith(result: result, isScanning: false);
    } catch (e) {
      state = state.copyWith(
        isScanning: false,
        error: friendlyError(e, fallback: 'No se pudo analizar la imagen. Intenta con una foto más clara.'),
      );
    }
  }

  Future<void> confirmExpense(SupplierInvoiceConfirmPayload payload) async {
    state = state.copyWith(isConfirming: true, error: null);

    try {
      final endpoints = ref.read(endpointsProvider);
      final response = await endpoints.confirmScan(payload);
      state = state.copyWith(isConfirming: false, confirmed: response);
    } catch (e) {
      state = state.copyWith(
        isConfirming: false,
        error: friendlyError(e, fallback: 'No se pudo guardar la factura. Intenta de nuevo.'),
      );
    }
  }

  void reset() {
    state = const ScanState();
  }
}

final scanProvider = NotifierProvider<ScanNotifier, ScanState>(ScanNotifier.new);
