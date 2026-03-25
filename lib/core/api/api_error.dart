class ApiError implements Exception {
  final int status;
  final String code;
  final String message;
  final int? retryAfter;

  ApiError({
    required this.status,
    required this.code,
    required this.message,
    this.retryAfter,
  });

  @override
  String toString() => 'ApiError($status, $code): $message';

  bool get isUnauthorized => status == 401;
  bool get isForbidden => status == 403;
  bool get isNotFound => status == 404;
  bool get isRateLimited => status == 429;
}
