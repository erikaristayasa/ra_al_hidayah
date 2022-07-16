import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/change_password_repository.dart';

abstract class ChangePasswordUseCase<Type> {
  Future<Either<Failure, bool>> call({
    required String password,
    required String passwordConfirmation,
    required String token,
  });
}

class ChangePassword implements ChangePasswordUseCase<bool> {
  final ChangePasswordRepository repository;

  ChangePassword({required this.repository});

  @override
  Future<Either<Failure, bool>> call({
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    return await repository.updatePassword(
      password: password,
      passwordConfirmation: passwordConfirmation,
      token: token,
    );
  }
}
