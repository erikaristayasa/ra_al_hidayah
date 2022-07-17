import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/registration_period_entity.dart';
import '../../../domain/usecases/get_registration_period.dart';

part 'registration_period_event.dart';
part 'registration_period_state.dart';

class RegistrationPeriodBloc extends Bloc<RegistrationPeriodEvent, RegistrationPeriodState> {
  final GetRegistrationPeriod getRegistrationPeriod;
  RegistrationPeriodBloc({required this.getRegistrationPeriod}) : super(RegistrationPeriodInitial()) {
    on<FetchPeriod>((event, emit) async {
      emit(RegistrationPeriodLoading());

      final result = await getRegistrationPeriod();
      result.fold(
        (failure) => emit(RegistrationPeriodFailure(failure: failure)),
        (data) => emit(RegistrationPeriodLoaded(data: data)),
      );
    });
  }
}
