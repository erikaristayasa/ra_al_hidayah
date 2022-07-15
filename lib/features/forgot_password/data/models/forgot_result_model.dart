import 'package:equatable/equatable.dart';

class ForgotResultModel extends Equatable {
  final String token;

  const ForgotResultModel({required this.token});

  @override
  List<Object?> get props => [token];

  factory ForgotResultModel.fromJson(Map<String, dynamic> json) => ForgotResultModel(
        token: json['token'],
      );
}
