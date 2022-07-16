import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, bool>> updatePassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  });
}
