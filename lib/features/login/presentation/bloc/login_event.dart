part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Submit extends LoginEvent {
  final String phone;
  final String password;

  const Submit({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];
}
