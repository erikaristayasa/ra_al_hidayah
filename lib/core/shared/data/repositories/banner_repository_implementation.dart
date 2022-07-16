import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../../networks/networks.dart';
import '../../../statics/statics.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_data_source.dart';

class BannerRepositoryImplementation implements BannerRepository {
  final ConnectivityInfo connectivityInfo;
  final BannerDataSource dataSource;

  BannerRepositoryImplementation({
    required this.connectivityInfo,
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Banner>>> list(BannerType type) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.list(type);
        return Right(result.data);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
