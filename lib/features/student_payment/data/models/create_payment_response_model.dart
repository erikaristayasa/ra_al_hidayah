import 'package:equatable/equatable.dart';

class CreatePaymentResponseModel extends Equatable {
  final String message;
  final int? id;

  const CreatePaymentResponseModel({required this.message, required this.id});

  @override
  List<Object?> get props => [
        message,
        id,
      ];

  factory CreatePaymentResponseModel.fromJson(Map<String, dynamic> json) => CreatePaymentResponseModel(
        message: json['message'],
        id: json['data'] != null ? json['data']['id'] : null,
      );
}
