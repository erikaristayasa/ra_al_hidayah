part of 'student_registration_bloc.dart';

abstract class StudentRegistrationState extends Equatable {
  const StudentRegistrationState();  

  @override
  List<Object> get props => [];
}
class StudentRegistrationInitial extends StudentRegistrationState {}
