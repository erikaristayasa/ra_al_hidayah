part of 'create_payment_bloc.dart';

abstract class CreatePaymentEvent extends Equatable {
  const CreatePaymentEvent();

  @override
  List<Object> get props => [];
}

class Submit extends CreatePaymentEvent {
  final PaymentBody body;

  const Submit({required this.body});

  @override
  List<Object> get props => [body];
}
