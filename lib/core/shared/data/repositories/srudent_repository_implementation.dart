import 'package:dartz/dartz.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../errors/failure.dart';
import '../../../networks/networks.dart';
import '../../../statics/statics.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_data_source.dart';

class StudentRepositoryImplementation implements StudentRepository {
  final ConnectivityInfo connectivityInfo;
  final StudentDataSource dataSource;

  StudentRepositoryImplementation({required this.connectivityInfo, required this.dataSource});

  @override
  Future<Either<Failure, List<Student>>> list({required PaymentStatus? status, required String? name, GradeType? type}) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.list(status: status, name: name);
        AppHelpers.logMe(result);
        if (type != null) {
          final _filtered = result.data.takeWhile((value) => value.type == type);
          return Right(_filtered.toList());
        } else {
          return Right(result.data);
        }
      } catch (e) {
        AppHelpers.logMe(e.toString());
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
