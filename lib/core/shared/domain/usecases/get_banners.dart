import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../../statics/statics.dart';
import '../entities/banner_entity.dart';
import '../repositories/banner_repository.dart';

abstract class BannerUseCase<Type> {
  Future<Either<Failure, List<Banner>>> call(BannerType type);
}

class GetBanners implements BannerUseCase<List<Banner>> {
  final BannerRepository repository;

  GetBanners({required this.repository});

  @override
  Future<Either<Failure, List<Banner>>> call(BannerType type) async {
    return await repository.list(type);
  }
}
