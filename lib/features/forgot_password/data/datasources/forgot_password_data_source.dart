import 'package:dio/dio.dart';

import '../models/forgot_password_response_model.dart';

abstract class ForgotPasswordDataSource {
  Future<ForgotPasswordResponseModel> forgotPassword(String phone);
}

class ForgotPasswordDataSourceImplementation implements ForgotPasswordDataSource {
  final Dio dio;

  ForgotPasswordDataSourceImplementation({required this.dio});

  @override
  Future<ForgotPasswordResponseModel> forgotPassword(String phone) async {
    const path = 'api/forgot-password';
    try {
      final response = await dio.post(path, data: {'telepon': phone});
      return ForgotPasswordResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
