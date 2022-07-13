part of 'text_controller_bloc.dart';

abstract class TextControllerEvent extends Equatable {
  const TextControllerEvent();

  @override
  List<Object> get props => [];
}

class TextControllerOnChanged extends TextControllerEvent {
  final String newValue;

  const TextControllerOnChanged({required this.newValue});
}

class TextControllerOnError extends TextControllerEvent {
  final bool error;

  const TextControllerOnError(this.error);
}
