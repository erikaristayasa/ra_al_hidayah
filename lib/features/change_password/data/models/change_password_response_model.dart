import 'package:equatable/equatable.dart';

class ChangePasswordResponseModel extends Equatable {
  final String message;

  const ChangePasswordResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) => ChangePasswordResponseModel(
        message: json['message'],
      );
}
