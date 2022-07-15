part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class Submit extends ForgotPasswordEvent {
  final String phone;

  const Submit({required this.phone});

  @override
  List<Object> get props => [phone];
}
