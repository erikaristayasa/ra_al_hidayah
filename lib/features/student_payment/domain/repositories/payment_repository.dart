import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/payment_body_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class PaymentRepository {
  Future<Either<Failure, int>> create(PaymentBody body);
  Future<Either<Failure, bool>> update({required int id, required XFile file});
}
