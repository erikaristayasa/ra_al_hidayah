import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

abstract class LoginUseCase<Type> {
  Future<Either<Failure, Login>> call({
    required String phone,
    required String password,
  });
}

class DoLogin implements LoginUseCase<Login> {
  final LoginRepository repository;

  DoLogin({required this.repository});
  @override
  Future<Either<Failure, Login>> call({required String phone, required String password}) async {
    return await repository.doLogin(phone: phone, password: password);
  }
}
