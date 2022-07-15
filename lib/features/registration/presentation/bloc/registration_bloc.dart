import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/do_registration.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final DoRegistration doRegistration;
  RegistrationBloc({required this.doRegistration}) : super(RegistrationInitial()) {
    on<Submit>((event, emit) async {
      emit(RegistrationLoading());

      final result = await doRegistration(
        name: event.name,
        address: event.address,
        phone: event.phone,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );

      result.fold(
        (failure) => emit(RegistrationFailure(failure: failure)),
        (_) => emit(RegistrationSuccess()),
      );
    });
  }
}
