import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'text_controller_event.dart';
part 'text_controller_state.dart';

class TextControllerBloc extends Bloc<TextControllerEvent, TextControllerState> {
  TextControllerBloc() : super(const TextControllerInitial('', false)) {
    on<TextControllerOnChanged>((event, emit) {
      emit(TextControllerInitial(event.newValue, state.error));
    });

    on<TextControllerOnError>((event, emit) {
      emit(TextControllerInitial(state.value, event.error));
    });
  }
}
