import 'package:equatable/equatable.dart';

class ValidateOtpResponseModel extends Equatable {
  final String message;

  const ValidateOtpResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory ValidateOtpResponseModel.fromJson(Map<String, dynamic> json) => ValidateOtpResponseModel(message: json['message']);
}
