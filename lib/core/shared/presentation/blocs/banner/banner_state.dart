part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<Banner> data;

  const BannerLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class BannerFailure extends BannerState {
  final Failure failure;

  const BannerFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
