import 'package:equatable/equatable.dart';

class ProfileUpdateResponseModel extends Equatable {
  final String message;

  const ProfileUpdateResponseModel({required this.message});

  @override
  List<Object?> get props => [message];

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) => ProfileUpdateResponseModel(
        message: json['message'],
      );
}
