import 'package:dio/dio.dart';

import '../../../../core/statics/statics.dart';
import '../models/change_password_response_model.dart';

abstract class ChangePasswordDataSource {
  Future<ChangePasswordResponseModel> updatePassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  });
}

class ChangePasswordDataSourceImplementation implements ChangePasswordDataSource {
  final Dio dio;

  ChangePasswordDataSourceImplementation({required this.dio});

  @override
  Future<ChangePasswordResponseModel> updatePassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    const path = 'api/orang-tua/profile/update-password';
    try {
      dio.withToken(token: token);
      final response = await dio.post(path, data: {
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      return ChangePasswordResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
