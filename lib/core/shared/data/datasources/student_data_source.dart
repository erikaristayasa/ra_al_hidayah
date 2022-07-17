import 'package:dio/dio.dart';

import '../../../statics/statics.dart';
import '../models/student_list_response_model.dart';

abstract class StudentDataSource {
  Future<StudentListResponseModel> list({required PaymentStatus? status, required String? name});
}

class StudentDataSourceImplementation implements StudentDataSource {
  final Dio dio;

  StudentDataSourceImplementation({required this.dio});

  @override
  Future<StudentListResponseModel> list({required PaymentStatus? status, required String? name}) async {
    const path = 'api/orang-tua/pembayaran/list';
    final param = {
      if (status != null) 'status': status.postValue,
      if (name != null) 'nama_lengkap': name,
    };
    try {
      final response = await dio.get(path, queryParameters: param);
      return StudentListResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
