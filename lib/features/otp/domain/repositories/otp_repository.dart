import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class OtpRepository {
  Future<Either<Failure, bool>> validate({required String token, required String code});
}
