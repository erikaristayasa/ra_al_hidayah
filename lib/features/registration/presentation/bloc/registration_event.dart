part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class Submit extends RegistrationEvent {
  final String name;
  final String address;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const Submit({
    required this.name,
    required this.address,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [
        name,
        address,
        phone,
        password,
        passwordConfirmation,
      ];
}
