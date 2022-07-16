part of 'utilities.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // blocs & cubits
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator()));
  locator.registerFactory<RegistrationBloc>(() => RegistrationBloc(doRegistration: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(doForgotPassword: locator()));
  locator.registerFactory<OtpBloc>(() => OtpBloc(validateOtp: locator()));
  locator.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc());
  locator.registerFactory<BannerBloc>(() => BannerBloc(getBanners: locator()));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(repository: locator()));
  locator.registerLazySingleton<DoRegistration>(() => DoRegistration(repository: locator()));
  locator.registerLazySingleton<DoForgotPassword>(() => DoForgotPassword(repository: locator()));
  locator.registerLazySingleton<ValidateOtp>(() => ValidateOtp(repository: locator()));
  locator.registerLazySingleton<GetBanners>(() => GetBanners(repository: locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator
      .registerLazySingleton<RegistrationRepository>(() => RegistrationRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<OtpRepository>(() => OtpRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<BannerRepository>(() => BannerRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegistrationDataSource>(() => RegistrationDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(() => ForgotPasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<OtpDataSource>(() => OtpDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<BannerDataSource>(() => BannerDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<ConnectivityInfo>(() => ConnectivityInfoImplementation(connectivity: Connectivity()));

  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
