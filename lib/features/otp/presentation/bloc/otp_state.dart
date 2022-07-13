part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpValid extends OtpState {}

class OtpInvalid extends OtpState {
  final Failure failure;

  const OtpInvalid({required this.failure});
  @override
  List<Object> get props => [failure];
}
