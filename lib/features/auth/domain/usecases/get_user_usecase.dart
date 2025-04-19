import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  Future<User?> call() => repository.getUser();
}
