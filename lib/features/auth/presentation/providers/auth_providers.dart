import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../auth/domain/usecases/login_usecase.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';
import '../../../auth/domain/usecases/get_user_usecase.dart';
import '../../../auth/domain/entities/user.dart';

final googleSignInProvider = Provider((ref) => GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/drive',
        'https://www.googleapis.com/auth/drive.file'
      ],
    ));

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(
    ref.read(googleSignInProvider),
    ref.read(secureStorageProvider),
  );
});

final loginUseCaseProvider =
    Provider((ref) => LoginUseCase(ref.read(authRepositoryProvider)));
final logoutUseCaseProvider =
    Provider((ref) => LogoutUseCase(ref.read(authRepositoryProvider)));
final getUserUseCaseProvider =
    Provider((ref) => GetUserUseCase(ref.read(authRepositoryProvider)));

final authUserProvider = FutureProvider<User?>((ref) async {
  return await ref.read(getUserUseCaseProvider).call();
});
