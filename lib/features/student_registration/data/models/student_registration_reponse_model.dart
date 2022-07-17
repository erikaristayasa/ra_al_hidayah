import 'package:equatable/equatable.dart';

class StudentRegistrationResponseModel extends Equatable {
  final String message;

  const StudentRegistrationResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory StudentRegistrationResponseModel.fromJson(Map<String, dynamic> json) => StudentRegistrationResponseModel(message: json['message']);
}
