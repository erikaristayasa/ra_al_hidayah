import 'package:dartz/dartz.dart';
import '../repositories/student_repository.dart';

import '../../../errors/failure.dart';
import '../../../statics/statics.dart';
import '../entities/student_entity.dart';

abstract class GetStudentUseCase<Type> {
  Future<Either<Failure, List<Student>>> call({required PaymentStatus? status, required String? name, GradeType? type});
}

class GetStudents implements GetStudentUseCase<List<Student>> {
  final StudentRepository repository;

  GetStudents({required this.repository});

  @override
  Future<Either<Failure, List<Student>>> call({required PaymentStatus? status, required String? name, GradeType? type}) async {
    return await repository.list(status: status, name: name);
  }
}
