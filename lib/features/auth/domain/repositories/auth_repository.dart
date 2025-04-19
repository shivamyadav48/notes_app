import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login();
  Future<void> logout();
  Future<User?> getUser();
}
