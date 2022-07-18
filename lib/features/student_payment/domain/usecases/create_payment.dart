import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../repositories/payment_repository.dart';

abstract class CreatePaymentUseCase<Type> {
  Future<Either<Failure, int>> call(PaymentBody body);
}

class CreatePayment implements CreatePaymentUseCase<int> {
  final PaymentRepository repository;

  CreatePayment({required this.repository});

  @override
  Future<Either<Failure, int>> call(PaymentBody body) async {
    return await repository.create(body);
  }
}
