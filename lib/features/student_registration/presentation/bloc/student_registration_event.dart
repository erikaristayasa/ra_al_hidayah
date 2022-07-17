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
  final String? phone;
  final XFile? birthDocumentFile;
  final XFile? registrationFormFile;
  final XFile? availabilityFile;
  final XFile? profOfPaymentFile;

  const Submit(
  {
    required this.registrationPeriodId,
    required this.studentId,
    required this.type,
    required this.name,
    required this.gender,
    required this.birthPlace,
    required this.birthDate,
    required this.nik,
    required this.religion,
    required this.childNumber,
    required this.fatherName,
    required this.motherName,
    required this.parentJob,
    required this.address,
    required this.phone,
    required this.birthDocumentFile,
    required this.registrationFormFile,
    required this.availabilityFile,
    required this.profOfPaymentFile,
  }
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
        phone,
        birthDocumentFile,
        registrationFormFile,
        availabilityFile,
        profOfPaymentFile,
      ];
}
