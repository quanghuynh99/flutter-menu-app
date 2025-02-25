class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache operation failed']);

  @override
  String toString() => 'CacheException: $message';
}
