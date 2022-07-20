import 'package:equatable/equatable.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/registration_period_entity.dart';

import '../../../statics/statics.dart';
import 'payment_status_entity.dart';

class Student extends Equatable {
  final int id;
  final int parentId;
  final int periodId;
  final GradeType type;
  final String name;
  final Gender? gender;
  final String birthPlace;
  final DateTime? birthDate;
  final String nik;
  final String religion;
  final String childNumber;
  final String fatherName;
  final String motherName;
  final String parentJob;
  final String address;
  final String phone;
  final String fileBirthDocument;
  final String fileRegistrationForm;
  final String fileAvailability;
  final String fileProfOfPayment;
  final PaymentStatus status;
  final String rejectNote;
  final DateTime? endPaymentDate;
  final PaymentsStatus paymentsStatus;
  final RegistrationPeriod? registrationPeriod;

  const Student({
    required this.id,
    required this.parentId,
    required this.periodId,
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
    required this.fileBirthDocument,
    required this.fileRegistrationForm,
    required this.fileAvailability,
    required this.fileProfOfPayment,
    required this.status,
    required this.rejectNote,
    required this.endPaymentDate,
    required this.paymentsStatus,
    required this.registrationPeriod,
  });

  @override
  List<Object?> get props => [
        id,
        parentId,
        periodId,
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
        fileBirthDocument,
        fileRegistrationForm,
        fileAvailability,
        fileProfOfPayment,
        status,
        rejectNote,
        endPaymentDate,
        paymentsStatus,
        registrationPeriod,
      ];
}
