import 'package:equatable/equatable.dart';

import 'registration_period_model.dart';

class RegistrationPeriodResponseModel extends Equatable {
  final String message;
  final RegistrationPeriodModel? data;

  const RegistrationPeriodResponseModel({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [message, data];

  factory RegistrationPeriodResponseModel.fromJson(Map<String, dynamic> json) => RegistrationPeriodResponseModel(
        message: json['message'],
        data: json['data'] != null ? RegistrationPeriodModel.fromJson(json['data']) : null,
      );
}
