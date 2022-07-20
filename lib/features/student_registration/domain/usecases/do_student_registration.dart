import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/student_registration_repository.dart';

abstract class RegistrationUseCase<Type> {
  Future<Either<Failure, bool>> call({
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
    required bool isUpdate,
  });
}

class DoStudentRegistration implements RegistrationUseCase<bool> {
  final StudentRegistrationRepository repository;

  DoStudentRegistration({required this.repository});

  @override
  Future<Either<Failure, bool>> call({
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
    required bool isUpdate,
  }) async {
    return await repository.create(
      registrationPeriodId: registrationPeriodId,
      studentId: studentId,
      type: type,
      name: name,
      gender: gender,
      birthPlace: birthPlace,
      birthDate: birthDate,
      nik: nik,
      religion: religion,
      childNumber: childNumber,
      fatherName: fatherName,
      motherName: motherName,
      parentJob: parentJob,
      address: address,
      phone: phone,
      birthDocumentFile: birthDocumentFile,
      registrationFormFile: registrationFormFile,
      availabilityFile: availabilityFile,
      profOfPaymentFile: profOfPaymentFile,
      isDraft: isDraft,
      isUpdate: isUpdate,
    );
  }
}
