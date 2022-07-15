import 'package:equatable/equatable.dart';

class ForgotResultModel extends Equatable {
  final String token;
  final dynamic code;

  const ForgotResultModel({required this.token, required this.code});

  @override
  List<Object?> get props => [token, code];

  factory ForgotResultModel.fromJson(Map<String, dynamic> json) => ForgotResultModel(
        token: json['token'],
        code: json['user'] != null ? json['user']['otp'] : ''
      );
}
