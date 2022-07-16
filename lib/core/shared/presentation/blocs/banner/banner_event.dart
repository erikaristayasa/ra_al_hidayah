part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends BannerEvent {
  final BannerType type;

  const Fetch({required this.type});

  @override
  List<Object> get props => [type];
}
