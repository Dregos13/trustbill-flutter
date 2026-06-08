import 'package:dio/dio.dart';
import '../api/api_error.dart';

String friendlyError(dynamic e, {String fallback = 'Algo salió mal. Intenta de nuevo.'}) {
  if (e is ApiError) return _fromApiError(e, fallback);
  if (e is DioException) return _fromDio(e);
  return fallback;
}

String _fromApiError(ApiError e, String fallback) {
  switch (e.code) {
    case 'DUPLICATE_EMAIL':
    case 'EMAIL_EXISTS':
      return 'Este correo ya está registrado.';
    case 'DUPLICATE_TAX_ID':
      return 'Este CIF/NIF ya está registrado.';
    case 'VALIDATION_ERROR':
      return e.message.isNotEmpty ? e.message : 'Datos no válidos. Revisa los campos.';
    case 'UNAUTHORIZED':
      return 'Sesión expirada. Vuelve a iniciar sesión.';
    case 'FORBIDDEN':
      return 'No tienes permiso para realizar esta acción.';
    case 'NOT_FOUND':
      return 'No se encontró el recurso solicitado.';
    case 'RATE_LIMITED':
      return 'Demasiadas solicitudes. Espera un momento e intenta de nuevo.';
    case 'FILE_TOO_LARGE':
      return 'El archivo es demasiado grande. Usa una imagen más pequeña.';
    case 'INVALID_FILE_TYPE':
      return 'Formato de archivo no compatible. Usa JPG o PNG.';
    default:
      if (e.message.isNotEmpty && e.message.length < 200) return e.message;
      return fallback;
  }
}

String _fromDio(DioException e) {
  if (e.error is ApiError) return _fromApiError(e.error as ApiError, 'Error del servidor.');
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'La conexión tardó demasiado. Comprueba tu internet e intenta de nuevo.';
    case DioExceptionType.connectionError:
      return 'No se pudo conectar con el servidor. Comprueba tu internet.';
    case DioExceptionType.badResponse:
      final status = e.response?.statusCode ?? 0;
      if (status >= 500) return 'El servidor no está disponible. Intenta más tarde.';
      if (status == 413) return 'El archivo es demasiado grande.';
      return 'Error del servidor. Intenta de nuevo.';
    case DioExceptionType.cancel:
      return 'Solicitud cancelada.';
    default:
      return 'Error de conexión. Comprueba tu internet e intenta de nuevo.';
  }
}
