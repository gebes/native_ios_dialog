/// This exception is thrown, when `.show()` is called on a different platform
class WrongPlatformException implements Exception {
  String cause;

  WrongPlatformException(this.cause);
}
