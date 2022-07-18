part of 'utilities.dart';

final locator = GetIt.instance;

Future<void> locatorSetup() async {
  // blocs & cubits
  locator.registerFactory<LoginBloc>(() => LoginBloc(doLogin: locator()));
  locator.registerFactory<RegistrationBloc>(() => RegistrationBloc(doRegistration: locator()));
  locator.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(doForgotPassword: locator()));
  locator.registerFactory<OtpBloc>(() => OtpBloc(validateOtp: locator()));
  locator.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc(changePassword: locator()));
  locator.registerFactory<BannerBloc>(() => BannerBloc(getBanners: locator()));
  locator.registerFactory<RegistrationPeriodBloc>(() => RegistrationPeriodBloc(getRegistrationPeriod: locator()));
  locator.registerFactory<StudentRegistrationBloc>(() => StudentRegistrationBloc(doStudentRegistration: locator()));
  locator.registerFactory<StudentListBloc>(() => StudentListBloc(getStudents: locator()));
  locator.registerFactory<CreatePaymentBloc>(() => CreatePaymentBloc(createPayment: locator()));
  locator.registerFactory<UpdatePaymentBloc>(() => UpdatePaymentBloc(updatePayment: locator()));

  // use cases
  locator.registerLazySingleton<DoLogin>(() => DoLogin(repository: locator()));
  locator.registerLazySingleton<DoRegistration>(() => DoRegistration(repository: locator()));
  locator.registerLazySingleton<DoForgotPassword>(() => DoForgotPassword(repository: locator()));
  locator.registerLazySingleton<ValidateOtp>(() => ValidateOtp(repository: locator()));
  locator.registerLazySingleton<ChangePassword>(() => ChangePassword(repository: locator()));
  locator.registerLazySingleton<GetBanners>(() => GetBanners(repository: locator()));
  locator.registerLazySingleton<GetRegistrationPeriod>(() => GetRegistrationPeriod(repository: locator()));
  locator.registerLazySingleton<DoStudentRegistration>(() => DoStudentRegistration(repository: locator()));
  locator.registerLazySingleton<GetStudents>(() => GetStudents(repository: locator()));
  locator.registerLazySingleton<CreatePayment>(() => CreatePayment(repository: locator()));
  locator.registerLazySingleton<UpdatePayment>(() => UpdatePayment(repository: locator()));

  // repositories
  locator.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator
      .registerLazySingleton<RegistrationRepository>(() => RegistrationRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<OtpRepository>(() => OtpRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<BannerRepository>(() => BannerRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<StudentRegistrationRepository>(
      () => StudentRegistrationRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<StudentRepository>(() => StudentRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));
  locator.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImplementation(dataSource: locator(), connectivityInfo: locator()));

  // data sources
  locator.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<RegistrationDataSource>(() => RegistrationDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ForgotPasswordDataSource>(() => ForgotPasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<OtpDataSource>(() => OtpDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<ChangePasswordDataSource>(() => ChangePasswordDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<BannerDataSource>(() => BannerDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<StudentRegistrationDataSource>(() => StudentRegistrationDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<DownloadDataSource>(() => DownloadDataSourceImplementation());
  locator.registerLazySingleton<StudentDataSource>(() => StudentDataSourceImplementation(dio: locator()));
  locator.registerLazySingleton<PaymentDataSource>(() => PaymentDataSourceImplementation(dio: locator()));

  // core
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingleton<ConnectivityInfo>(() => ConnectivityInfoImplementation(connectivity: Connectivity()));

  // external
  locator.registerLazySingletonAsync<SharedPreferencesHelper>(
    () async => await SharedPreferencesHelper().init(),
  );
}
