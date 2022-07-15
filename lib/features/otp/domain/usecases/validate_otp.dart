import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/otp_repository.dart';

abstract class OtpUseCase<Type> {
  Future<Either<Failure, bool>> call({required String token, required String code});
}

class ValidateOtp implements OtpUseCase<Type> {
  final OtpRepository repository;

  ValidateOtp({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required String token, required String code}) async {
    return await repository.validate(token: token, code: code);
  }
}
