import 'package:equatable/equatable.dart';

class RegistrationResponseModel extends Equatable {
  final String message;

  const RegistrationResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => RegistrationResponseModel(
        message: json['message'] ?? '',
      );
}
