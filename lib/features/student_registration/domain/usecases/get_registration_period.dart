import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/registration_period_entity.dart';
import '../repositories/student_registration_repository.dart';

abstract class RegistrationPeriodUseCase<Type> {
  Future<Either<Failure, RegistrationPeriod>> call();
}

class GetRegistrationPeriod implements RegistrationPeriodUseCase<RegistrationPeriod> {
  final StudentRegistrationRepository repository;

  GetRegistrationPeriod({required this.repository});

  @override
  Future<Either<Failure, RegistrationPeriod>> call() async {
    return await repository.checkRegistrationPeriod();
  }
}
