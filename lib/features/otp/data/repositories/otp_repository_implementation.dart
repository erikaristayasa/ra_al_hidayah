import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_data_source.dart';

class OtpRepositoryImplementation implements OtpRepository {
  final ConnectivityInfo connectivityInfo;
  final OtpDataSource dataSource;

  OtpRepositoryImplementation({required this.connectivityInfo, required this.dataSource});

  @override
  Future<Either<Failure, bool>> validate({required String token, required String code}) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.validate(token: token, code: code);
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
