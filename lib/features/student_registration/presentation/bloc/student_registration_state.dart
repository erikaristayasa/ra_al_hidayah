part of 'student_registration_bloc.dart';

abstract class StudentRegistrationState extends Equatable {
  const StudentRegistrationState();

  @override
  List<Object> get props => [];
}

class StudentRegistrationInitial extends StudentRegistrationState {}

class StudentRegistrationLoading extends StudentRegistrationState {}

class StudentRegistrationSuccess extends StudentRegistrationState {}

class StudentRegistrationFailure extends StudentRegistrationState {
  final Failure failure;

  const StudentRegistrationFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
