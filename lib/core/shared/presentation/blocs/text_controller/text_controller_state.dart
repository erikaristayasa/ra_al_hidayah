part of 'text_controller_bloc.dart';

abstract class TextControllerState extends Equatable {
  final String value;
  final bool error;
  const TextControllerState(this.value, this.error);

  @override
  List<Object> get props => [value, error];
}

class TextControllerInitial extends TextControllerState {
  const TextControllerInitial(String value, bool error) : super(value, error);
}

class TextControllerError extends TextControllerState {
  final String message;

  const TextControllerError({required this.message}) : super('', true);

  @override
  List<Object> get props => [message];
}
