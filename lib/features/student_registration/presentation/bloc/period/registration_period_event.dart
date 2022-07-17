part of 'registration_period_bloc.dart';

abstract class RegistrationPeriodEvent extends Equatable {
  const RegistrationPeriodEvent();

  @override
  List<Object> get props => [];
}

class FetchPeriod extends RegistrationPeriodEvent {}
