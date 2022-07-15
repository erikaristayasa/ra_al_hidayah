import 'package:dartz/dartz.dart';
import 'package:ra_al_hidayah/core/errors/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> doForgotPassword(String phone);
}
