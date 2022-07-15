import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../../../core/utilities/utilities.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_data_source.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final ConnectivityInfo connectivityInfo;
  final LoginDataSource dataSource;

  LoginRepositoryImplementation({
    required this.connectivityInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, Login>> doLogin({required String phone, required String password}) async {
    if (await connectivityInfo.isConnected) {
      final result = await dataSource.doLogin(phone: phone, password: password);
      if (result.data != null) {
        await AppHelpers.savingSession(result.data!);
        return Right(result.data!);
      } else {
        return Left(ServerFailure(message: result.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
