import 'package:equatable/equatable.dart';

import 'student_model.dart';

class StudentListResponseModel extends Equatable {
  final String message;
  final List<StudentModel> data;

  const StudentListResponseModel({required this.message, required this.data});

  @override
  List<Object?> get props => [
        message,
        data,
      ];

  factory StudentListResponseModel.fromJson(Map<String, dynamic> json) => StudentListResponseModel(
        message: json['message'],
        data: json['data'] != null ? List<StudentModel>.from(json['data'].map((x) => StudentModel.fromJson(x))) : [],
      );
}
