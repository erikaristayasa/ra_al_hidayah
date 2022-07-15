import 'package:dartz/dartz.dart';
import '../repositories/registration_repository.dart';

import '../../../../core/errors/failure.dart';

abstract class RegistrationUseCase<Type> {
  Future<Either<Failure, bool>> call({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });
}

class DoRegistration implements RegistrationUseCase<bool> {
  final RegistrationRepository repository;

  DoRegistration({required this.repository});

  @override
  Future<Either<Failure, bool>> call({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await repository.doRegistration(
      name: name,
      address: address,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
