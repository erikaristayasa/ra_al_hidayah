part of 'update_payment_bloc.dart';

abstract class UpdatePaymentEvent extends Equatable {
  const UpdatePaymentEvent();

  @override
  List<Object> get props => [];
}

class Submit extends UpdatePaymentEvent {
  final XFile file;
  final int id;

  const Submit({required this.file, required this.id});

  @override
  List<Object> get props => [file, id];
}
