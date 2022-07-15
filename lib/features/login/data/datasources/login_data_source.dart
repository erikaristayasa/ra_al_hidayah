import 'package:dio/dio.dart';

import '../models/login_response_model.dart';

abstract class LoginDataSource {
  Future<LoginResponseModel> doLogin({
    required String phone,
    required String password,
  });
}

class LoginDataSourceImplementation implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImplementation({required this.dio});

  @override
  Future<LoginResponseModel> doLogin({required String phone, required String password}) async {
    const path = 'api/login';
    final data = {
      'telepon': phone,
      'password': password,
    };

    try {
      final response = await dio.post(path, data: data);
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
