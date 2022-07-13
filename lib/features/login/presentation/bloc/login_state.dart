part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final dynamic data;

  const LoginSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class LoginFailure extends LoginState {
  final Failure failure;

  const LoginFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
