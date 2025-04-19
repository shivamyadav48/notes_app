import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/app_exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._googleSignIn, this._secureStorage);

  @override
  Future<User> login() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) throw AuthException('Sign-in cancelled');

      final auth = await account.authentication;

      await _secureStorage.write(key: 'access_token', value: auth.accessToken);
      await _secureStorage.write(key: 'id_token', value: auth.idToken);

      return UserModel.fromGoogleSignInAccount(account);
    } catch (e) {
      throw AuthException('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'id_token');
  }

  @override
  Future<User?> getUser() async {
    final account =
        _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();
    if (account == null) return null;
    return UserModel.fromGoogleSignInAccount(account);
  }
}
