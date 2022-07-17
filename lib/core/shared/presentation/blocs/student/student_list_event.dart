part of 'student_list_bloc.dart';

abstract class StudentListEvent extends Equatable {
  const StudentListEvent();

  @override
  List<Object?> get props => [];
}

class FetchStudents extends StudentListEvent {
  final PaymentStatus? status;
  final String? name;
  final GradeType? type;

  const FetchStudents({required this.status, required this.name, required this.type});

  @override
  List<Object?> get props => [status, name, type];
}
