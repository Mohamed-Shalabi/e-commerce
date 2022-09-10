abstract class BaseException implements Exception {
  final String message;

  BaseException(this.message);

  @override
  String toString() {
    return 'error: $message';
  }
}