import 'package:dio/dio.dart';

import '../models/registration_response_model.dart';

abstract class RegistrationDataSource {
  Future<RegistrationResponseModel> doRegistration({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  });
}

class RegistrationDataSourceImplementation implements RegistrationDataSource {
  final Dio dio;

  RegistrationDataSourceImplementation({required this.dio});

  @override
  Future<RegistrationResponseModel> doRegistration({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    const path = 'api/register';
    final data = {
      'nama': name,
      'telepon': phone,
      'alamat': address,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    try {
      final response = await dio.post(path, data: data);
      return RegistrationResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
