part of 'utilities.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // blocs & cubits
  locator.registerFactory<LoginBloc>(() => LoginBloc());
  locator.registerFactory<RegistrationBloc>(() => RegistrationBloc());
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc());
  locator.registerFactory<OtpBloc>(() => OtpBloc());
  locator.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc());
  
  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<ConnectivityInfo>(() => ConnectivityInfoImplementation(connectivity: Connectivity()));

  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
