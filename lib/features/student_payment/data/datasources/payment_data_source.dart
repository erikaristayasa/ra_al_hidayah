import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../models/create_payment_response_model.dart';
import '../models/update_payment_response_model.dart';

abstract class PaymentDataSource {
  Future<CreatePaymentResponseModel> create(PaymentBody body);
  Future<UpdatePaymentResponseModel> update({required int id, required XFile file});
}

class PaymentDataSourceImplementation implements PaymentDataSource {
  final Dio dio;

  PaymentDataSourceImplementation({required this.dio});

  @override
  Future<CreatePaymentResponseModel> create(PaymentBody body) async {
    const path = 'api/orang-tua/pembayaran/create';
    try {
      dio.withToken();
      final response = await dio.post(path, data: body.toJson());
      AppHelpers.logMe(response.data);
      return CreatePaymentResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdatePaymentResponseModel> update({required int id, required XFile file}) async {
    final path = 'api/orang-tua/pembayaran/update/$id';
    final data = FormData.fromMap({
      'file_bukti_pembayaran': await MultipartFile.fromFile(file.path),
    });
    try {
      dio.withToken();
      final response = await dio.post(path, data: data);
      return UpdatePaymentResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
