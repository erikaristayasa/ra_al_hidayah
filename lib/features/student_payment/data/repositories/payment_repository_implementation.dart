import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_data_source.dart';

class PaymentRepositoryImplementation implements PaymentRepository {
  final ConnectivityInfo connectivityInfo;
  final PaymentDataSource dataSource;

  PaymentRepositoryImplementation({
    required this.connectivityInfo,
    required this.dataSource,
  });
  @override
  Future<Either<Failure, int>> create(PaymentBody body) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.create(body);
        if (result.id != null) {
          return Right(result.id!);
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

  @override
  Future<Either<Failure, bool>> update({required int id, required XFile file}) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.update(id: id, file: file);
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
