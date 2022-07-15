import 'package:dio/dio.dart';

import '../../../../core/statics/statics.dart';
import '../models/validate_otp_response_model.dart';

abstract class OtpDataSource {
  Future<ValidateOtpResponseModel> validate({required String token, required String code});
}

class OtpDataSourceImplementation implements OtpDataSource {
  final Dio dio;

  OtpDataSourceImplementation({required this.dio});

  @override
  Future<ValidateOtpResponseModel> validate({required String token, required String code}) async {
    const path = 'api/check-otp';
    try {
      dio.withToken(token: token);
      final response = await dio.post(path, data: {'otp': code});
      return ValidateOtpResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
