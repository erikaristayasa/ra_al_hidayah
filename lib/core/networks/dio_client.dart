part of 'networks.dart';

class DioClient {
  late Dio dio;
  final AppInterceptor appInterceptor = AppInterceptor();
  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      followRedirects: false,
      validateStatus: (status) => (status == 200) || (status == 400),
    ));
    dio.interceptors.addAll([appInterceptor, dioLoggerInterceptor]);
  }
}
