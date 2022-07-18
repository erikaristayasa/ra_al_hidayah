import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/payment_repository.dart';

abstract class UpdatePaymentUseCase<Type> {
  Future<Either<Failure, bool>> call({required int id, required XFile file});
}

class UpdatePayment implements UpdatePaymentUseCase<bool> {
  final PaymentRepository repository;

  UpdatePayment({required this.repository});

  @override
  Future<Either<Failure, bool>> call({required int id, required XFile file}) async {
    return await repository.update(id: id, file: file);
  }
}
