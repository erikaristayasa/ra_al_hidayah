part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String token;

  const ForgotPasswordSuccess({required this.token});

  @override
  List<Object> get props => [token];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final Failure failure;

  const ForgotPasswordFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
