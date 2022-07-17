import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../errors/failure.dart';
import '../../../../statics/statics.dart';
import '../../../domain/entities/student_entity.dart';
import '../../../domain/usecases/get_students.dart';

part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final GetStudents getStudents;
  StudentListBloc({required this.getStudents}) : super(StudentListInitial()) {
    on<FetchStudents>((event, emit) async {
      emit(StudentListLoading());

      final result = await getStudents(status: event.status, name: event.name);
      result.fold(
        (failure) => emit(StudentListFailure(failure: failure)),
        (data) => emit(StudentListLoaded(data: data)),
      );
    });
  }
}
