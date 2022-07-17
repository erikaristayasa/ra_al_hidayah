part of 'student_payment_bloc.dart';

abstract class StudentPaymentState extends Equatable {
  const StudentPaymentState();  

  @override
  List<Object> get props => [];
}
class StudentPaymentInitial extends StudentPaymentState {}
