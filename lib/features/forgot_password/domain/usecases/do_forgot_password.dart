import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/forgot_password_repository.dart';

abstract class ForgotUseCase<Type> {
  Future<Either<Failure, String>> call(String phone);
}

class DoForgotPassword implements ForgotUseCase<String> {
  final ForgotPasswordRepository repository;

  DoForgotPassword({required this.repository});

  @override
  Future<Either<Failure, String>> call(String phone) async {
    return await repository.doForgotPassword(phone);
  }
}
