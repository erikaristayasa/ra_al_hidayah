import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/re_registration_entity.dart';

class RegistrationPeriod extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int quotaTkA;
  final int quotaTkB;
  final int quotaPlaygroup;
  final String fileRegistrationForm;
  final String fileAvailability;
  final bool status;
  final ReRegistration reRegistration;

  const RegistrationPeriod({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.quotaTkA,
    required this.quotaTkB,
    required this.quotaPlaygroup,
    required this.fileRegistrationForm,
    required this.fileAvailability,
    required this.status,
    required this.reRegistration,
  });

  bool get isExpired => DateUtils.dateOnly(DateTime.now()).isAfter(endDate);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        quotaTkA,
        quotaTkB,
        quotaPlaygroup,
        fileRegistrationForm,
        fileAvailability,
        status,
        reRegistration,
      ];
}
