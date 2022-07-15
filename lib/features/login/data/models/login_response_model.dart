import 'package:equatable/equatable.dart';

import 'login_model.dart';

class LoginResponseModel extends Equatable {
  final String message;
  final LoginModel? data;

  const LoginResponseModel({required this.message, this.data});

  @override
  List<Object?> get props => [message, data];

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json['message'],
        data: json['data'] != null ? LoginModel.fromJson(json['data']) : null,
      );
}
