part of 'update_payment_bloc.dart';

abstract class UpdatePaymentState extends Equatable {
  const UpdatePaymentState();

  @override
  List<Object> get props => [];
}

class UpdatePaymentInitial extends UpdatePaymentState {}

class UpdatePaymentLoading extends UpdatePaymentState {}

class UpdatePaymentUpdated extends UpdatePaymentState {}

class UpdatePaymentFailure extends UpdatePaymentState {
  final Failure failure;

  const UpdatePaymentFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
