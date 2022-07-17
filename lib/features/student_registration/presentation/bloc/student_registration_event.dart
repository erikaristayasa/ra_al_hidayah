part of 'student_registration_bloc.dart';

abstract class StudentRegistrationEvent extends Equatable {
  const StudentRegistrationEvent();

  @override
  List<Object?> get props => [];
}

class Submit extends StudentRegistrationEvent {
  final int registrationPeriodId;
  final int? studentId;
  final String? type;
  final String? name;
  final String? gender;
  final String? birthPlace;
  final String? birthDate;
  final String? nik;
  final String? religion;
  final String? childNumber;
  final String? fatherName;
  final String? motherName;
  final String? parentJob;
  final String? address;
  final XFile? birthDocumentFile;
  final XFile? registrationFormFile;
  final XFile? availabilityFile;
  final XFile? profOfPaymentFile;

  const Submit(
    this.registrationPeriodId,
    this.studentId,
    this.type,
    this.name,
    this.gender,
    this.birthPlace,
    this.birthDate,
    this.nik,
    this.religion,
    this.childNumber,
    this.fatherName,
    this.motherName,
    this.parentJob,
    this.address,
    this.birthDocumentFile,
    this.registrationFormFile,
    this.availabilityFile,
    this.profOfPaymentFile,
  );

  @override
  List<Object?> get props => [
        registrationPeriodId,
        studentId,
        type,
        name,
        gender,
        birthPlace,
        birthDate,
        nik,
        religion,
        childNumber,
        fatherName,
        motherName,
        parentJob,
        address,
        birthDocumentFile,
        registrationFormFile,
        availabilityFile,
        profOfPaymentFile,
      ];
}
