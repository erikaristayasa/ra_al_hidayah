import 'package:dio/dio.dart';

import '../../../statics/statics.dart';
import '../models/banner_list_response_model.dart';

abstract class BannerDataSource {
  Future<BannerListResponseModel> list(BannerType type);
}

class BannerDataSourceImplementation implements BannerDataSource {
  final Dio dio;

  BannerDataSourceImplementation({required this.dio});

  @override
  Future<BannerListResponseModel> list(BannerType type) async {
    const path = 'api/banner/list-by-tipe';
    final param = {'tipe': type.text};
    try {
      final response = await dio.get(path, queryParameters: param);
      return BannerListResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
