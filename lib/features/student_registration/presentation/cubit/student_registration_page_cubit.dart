import 'package:bloc/bloc.dart';

class StudentRegistrationPageCubit extends Cubit<int> {
  StudentRegistrationPageCubit() : super(0);

  move(int page) => emit(page);
}
