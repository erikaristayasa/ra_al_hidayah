import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../domain/repositories/change_password_repository.dart';
import '../datasources/change_password_data_source.dart';

class ChangePasswordRepositoryImplementation implements ChangePasswordRepository {
  final ChangePasswordDataSource dataSource;
  final ConnectivityInfo connectivityInfo;

  ChangePasswordRepositoryImplementation({
    required this.dataSource,
    required this.connectivityInfo,
  });

  @override
  Future<Either<Failure, bool>> updatePassword({
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    if (await connectivityInfo.isConnected) {
      final result = await dataSource.updatePassword(
        password: password,
        passwordConfirmation: passwordConfirmation,
        token: token,
      );
      if (result.message == 'OK') {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: result.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
