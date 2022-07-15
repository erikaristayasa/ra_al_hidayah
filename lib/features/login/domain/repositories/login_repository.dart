import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> doLogin({
    required String phone,
    required String password,
  });
}
