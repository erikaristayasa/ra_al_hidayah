import 'package:equatable/equatable.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';

class Banner extends Equatable {
  final int id;
  final BannerType type;
  final String photo;

  const Banner({
    required this.id,
    required this.type,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        photo,
      ];
}
