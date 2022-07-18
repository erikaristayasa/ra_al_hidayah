import 'package:equatable/equatable.dart';

class UpdatePaymentResponseModel extends Equatable {
  final String message;

  const UpdatePaymentResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory UpdatePaymentResponseModel.fromJson(Map<String, dynamic> json) => UpdatePaymentResponseModel(message: json['message']);
}
