import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/scan_result.dart';
import '../../core/models/expense.dart';
import '../../core/auth/auth_provider.dart';

/// Holds the current scan result and image bytes while the user reviews.
class ScanState {
  final ScanResult? result;
  final Uint8List? imageBytes;
  final String? imageMimeType;
  final bool isScanning;
  final bool isConfirming;
  final String? error;
  final InvoiceCreatedResponse? confirmed;

  const ScanState({
    this.result,
    this.imageBytes,
    this.imageMimeType,
    this.isScanning = false,
    this.isConfirming = false,
    this.error,
    this.confirmed,
  });

  ScanState copyWith({
    ScanResult? result,
    Uint8List? imageBytes,
    String? imageMimeType,
    bool? isScanning,
    bool? isConfirming,
    String? error,
    InvoiceCreatedResponse? confirmed,
  }) {
    return ScanState(
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

class ScanNotifier extends StateNotifier<ScanState> {
  final Ref _ref;

  ScanNotifier(this._ref) : super(const ScanState());

  Future<void> scanImage(Uint8List bytes, String mimeType) async {
    state = ScanState(
      imageBytes: bytes,
      imageMimeType: mimeType,
      isScanning: true,
    );

    try {
      final endpoints = _ref.read(endpointsProvider);
      final result = await endpoints.scanReceipt(
        imageBytes: bytes,
        fileName: 'receipt.${mimeType == 'image/png' ? 'png' : 'jpg'}',
        mimeType: mimeType,
      );
      state = state.copyWith(result: result, isScanning: false);
    } catch (e) {
      state = state.copyWith(
        isScanning: false,
        error: 'Error al escanear: ${e.toString()}',
      );
    }
  }

  Future<void> confirmExpense(SupplierInvoiceConfirmPayload payload) async {
    state = state.copyWith(isConfirming: true, error: null);

    try {
      final endpoints = _ref.read(endpointsProvider);
      final response = await endpoints.confirmScan(payload);
      state = state.copyWith(isConfirming: false, confirmed: response);
    } catch (e) {
      state = state.copyWith(
        isConfirming: false,
        error: 'Error al guardar: ${e.toString()}',
      );
    }
  }

  void reset() {
    state = const ScanState();
  }
}

final scanProvider = StateNotifierProvider<ScanNotifier, ScanState>((ref) {
  return ScanNotifier(ref);
});
