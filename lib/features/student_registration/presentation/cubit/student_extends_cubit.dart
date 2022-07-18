import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/domain/entities/student_entity.dart';

class StudentExtendsCubit extends Cubit<Student?> {
  StudentExtendsCubit() : super(null);

  onSelected(Student? student) => emit(student);
}
