import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_payment_event.dart';
part 'student_payment_state.dart';

class StudentPaymentBloc extends Bloc<StudentPaymentEvent, StudentPaymentState> {
  StudentPaymentBloc() : super(StudentPaymentInitial()) {
    on<StudentPaymentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
