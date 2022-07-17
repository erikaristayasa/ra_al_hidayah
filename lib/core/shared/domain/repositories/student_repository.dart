import 'package:dartz/dartz.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';

import '../../../errors/failure.dart';
import '../entities/student_entity.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<Student>>> list({required PaymentStatus? status, required String? name, GradeType? type});
}
