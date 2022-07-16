import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../errors/failure.dart';
import '../../../../statics/statics.dart';
import '../../../domain/entities/banner_entity.dart';
import '../../../domain/usecases/get_banners.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanners getBanners;
  BannerBloc({required this.getBanners}) : super(BannerInitial()) {
    on<Fetch>((event, emit) async {
      emit(BannerLoading());

      final result = await getBanners(event.type);
      result.fold(
        (failure) => emit(BannerFailure(failure: failure)),
        (data) => emit(BannerLoaded(data: data)),
      );
    });
  }
}
