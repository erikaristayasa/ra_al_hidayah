import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/shared/domain/entities/registration_period_entity.dart';

abstract class StudentRegistrationRepository {
  Future<Either<Failure, RegistrationPeriod>> checkRegistrationPeriod();
  Future<Either<Failure, bool>> create({
    required int registrationPeriodId,
    required int? studentId,
    required String? type,
    required String? name,
    required String? gender,
    required String? birthPlace,
    required String? birthDate,
    required String? nik,
    required String? religion,
    required String? childNumber,
    required String? fatherName,
    required String? motherName,
    required String? parentJob,
    required String? address,
    required String? phone,
    required XFile? birthDocumentFile,
    required XFile? registrationFormFile,
    required XFile? availabilityFile,
    required XFile? profOfPaymentFile,
    required bool isDraft,
  });
}
