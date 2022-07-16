import 'forgot_result_model.dart';
import 'package:equatable/equatable.dart';

class ForgotPasswordResponseModel extends Equatable {
  final String message;
  final ForgotResultModel? data;

  const ForgotPasswordResponseModel({required this.message, required this.data});

  @override
  List<Object?> get props => [message, data];

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) => ForgotPasswordResponseModel(
        message: json['message'],
        data: json['data'] != null ? ForgotResultModel.fromJson(json['data']) : null,
      );
}
