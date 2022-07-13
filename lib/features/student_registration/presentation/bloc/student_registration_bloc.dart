import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_registration_event.dart';
part 'student_registration_state.dart';

class StudentRegistrationBloc extends Bloc<StudentRegistrationEvent, StudentRegistrationState> {
  StudentRegistrationBloc() : super(StudentRegistrationInitial()) {
    on<StudentRegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
