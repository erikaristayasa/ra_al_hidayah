part of 'utilities.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // blocs & cubits
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator()));
  locator.registerFactory<RegistrationBloc>(() => RegistrationBloc(doRegistration: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc());
  locator.registerFactory<OtpBloc>(() => OtpBloc());
  locator.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc());

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(repository: locator()));
  locator.registerLazySingleton<DoRegistration>(() => DoRegistration(repository: locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator
      .registerLazySingleton<RegistrationRepository>(() => RegistrationRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegistrationDataSource>(() => RegistrationDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<ConnectivityInfo>(() => ConnectivityInfoImplementation(connectivity: Connectivity()));

  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
