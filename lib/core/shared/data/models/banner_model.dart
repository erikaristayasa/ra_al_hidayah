import '../../../statics/statics.dart';
import '../../domain/entities/banner_entity.dart';

class BannerModel extends Banner {
  const BannerModel({
    required int id,
    required BannerType type,
    required String photo,
  }) : super(
          id: id,
          type: type,
          photo: photo,
        );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'],
        type: (json['tipe'] as String).bannerType,
        photo: json['foto'] ?? '',
      );
}
