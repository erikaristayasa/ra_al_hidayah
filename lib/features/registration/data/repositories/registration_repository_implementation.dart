import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../domain/repositories/registration_repository.dart';
import '../datasources/registration_data_source.dart';

class RegistrationRepositoryImplementation implements RegistrationRepository {
  final ConnectivityInfo connectivityInfo;
  final RegistrationDataSource dataSource;

  RegistrationRepositoryImplementation({
    required this.connectivityInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, bool>> doRegistration({
    required String name,
    required String address,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.doRegistration(
          name: name,
          address: address,
          phone: phone,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );
        if (result.message == 'OK') {
          return const Right(true);
        } else {
          return Left(ServerFailure(message: result.message));
        }
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
