import 'app_exceptions.dart';

class ErrorHandler {
  static String handleError(Exception error) {
    if (error is NetworkException) {
      return 'Network error: ${error.message}';
    } else if (error is AuthException) {
      return 'Authentication error: ${error.message}';
    } else if (error is DriveException) {
      return 'Drive error: ${error.message}';
    } else {
      return 'Unexpected error: ${error.toString()}';
    }
  }
}
