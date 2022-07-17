part of 'student_list_bloc.dart';

abstract class StudentListState extends Equatable {
  const StudentListState();

  @override
  List<Object> get props => [];
}

class StudentListInitial extends StudentListState {}

class StudentListLoading extends StudentListState {}

class StudentListLoaded extends StudentListState {
  final List<Student> data;

  const StudentListLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class StudentListFailure extends StudentListState {
  final Failure failure;

  const StudentListFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
