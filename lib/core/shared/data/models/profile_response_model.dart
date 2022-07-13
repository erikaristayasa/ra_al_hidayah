import 'package:equatable/equatable.dart';

import 'user_model.dart';

class ProfileResponseModel extends Equatable {
  final String message;
  final UserModel? data;

  const ProfileResponseModel({
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [message, data];

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
        message: json['message'],
        data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
      );
}
