part of 'create_payment_bloc.dart';

abstract class CreatePaymentState extends Equatable {
  const CreatePaymentState();

  @override
  List<Object> get props => [];
}

class CreatePaymentInitial extends CreatePaymentState {}

class CreatePaymentLoading extends CreatePaymentState {}

class CreatePaymentCreated extends CreatePaymentState {
  final int id;

  const CreatePaymentCreated({required this.id});

  @override
  List<Object> get props => [id];
}

class CreatePaymentFailure extends CreatePaymentState {
  final Failure failure;

  const CreatePaymentFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
