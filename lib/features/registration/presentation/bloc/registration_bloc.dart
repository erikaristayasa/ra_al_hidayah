import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
