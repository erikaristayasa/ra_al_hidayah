import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_data_source.dart';

class ForgotPasswordRepositoryImplementation implements ForgotPasswordRepository {
  final ForgotPasswordDataSource dataSource;
  final ConnectivityInfo connectivityInfo;

  ForgotPasswordRepositoryImplementation({
    required this.dataSource,
    required this.connectivityInfo,
  });

  @override
  Future<Either<Failure, String>> doForgotPassword(String phone) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.forgotPassword(phone);
        if (result.message == 'OK') {
          Fluttertoast.showToast(msg: '(for test) code: ${result.data.code}', toastLength: Toast.LENGTH_LONG);
          return Right(result.data.token);
        } else {
          return Left(ServerFailure(message: result.message));
        }
      } catch (e) {
        AppHelpers.logMe(e.toString());
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
