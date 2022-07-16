import 'package:dartz/dartz.dart';
import 'package:ra_al_hidayah/core/errors/failure.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/banner_entity.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';

abstract class BannerRepository {
  Future<Either<Failure, List<Banner>>> list(BannerType type);
}
