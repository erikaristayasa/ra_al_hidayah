part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}
class Submit extends ChangePasswordEvent {
  final String password;
  final String passwordConfirmation;
  final String token;

  const Submit({
    required this.password,
    required this.passwordConfirmation,
    required this.token,
  });
}
