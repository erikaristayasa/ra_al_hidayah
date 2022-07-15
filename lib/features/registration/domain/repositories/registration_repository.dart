import 'package:dartz/dartz.dart';
import 'package:ra_al_hidayah/core/errors/failure.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, bool>> doRegistration({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });
}
