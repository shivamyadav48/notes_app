class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(String message) : super(message);
}

class DriveException extends AppException {
  DriveException(String message) : super(message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
