part of 'registration_period_bloc.dart';

abstract class RegistrationPeriodState extends Equatable {
  const RegistrationPeriodState();

  @override
  List<Object> get props => [];
}

class RegistrationPeriodInitial extends RegistrationPeriodState {}

class RegistrationPeriodLoading extends RegistrationPeriodState {}

class RegistrationPeriodLoaded extends RegistrationPeriodState {
  final RegistrationPeriod data;

  const RegistrationPeriodLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class RegistrationPeriodFailure extends RegistrationPeriodState {
  final Failure failure;

  const RegistrationPeriodFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
