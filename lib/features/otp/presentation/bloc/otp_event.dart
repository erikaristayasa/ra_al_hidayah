part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class Validate extends OtpEvent {
  final String token, code;

  const Validate({required this.token, required this.code});

  @override
  List<Object> get props => [token, code];
}
