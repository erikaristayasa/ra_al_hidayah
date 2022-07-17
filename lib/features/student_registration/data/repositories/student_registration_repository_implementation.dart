import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networks.dart';
import '../../domain/entities/registration_period_entity.dart';
import '../../domain/repositories/student_registration_repository.dart';
import '../datasources/student_registration_data_source.dart';

class StudentRegistrationRepositoryImplementation implements StudentRegistrationRepository {
  final ConnectivityInfo connectivityInfo;
  final StudentRegistrationDataSource dataSource;

  StudentRegistrationRepositoryImplementation({required this.connectivityInfo, required this.dataSource});

  @override
  Future<Either<Failure, RegistrationPeriod>> checkRegistrationPeriod() async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.checkRegistrationPeriod();
        if (result.data != null) {
          return Right(result.data!);
        } else {
          return Left(ServerFailure(message: result.message));
        }
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> create({
    required int registrationPeriodId,
    required int? studentId,
    required String? type,
    required String? name,
    required String? gender,
    required String? birthPlace,
    required String? birthDate,
    required String? nik,
    required String? religion,
    required String? childNumber,
    required String? fatherName,
    required String? motherName,
    required String? parentJob,
    required String? address,
    required String? phone,
    required XFile? birthDocumentFile,
    required XFile? registrationFormFile,
    required XFile? availabilityFile,
    required XFile? profOfPaymentFile,
  }) async {
    if (await connectivityInfo.isConnected) {
      try {
        final result = await dataSource.create(
          registrationPeriodId: registrationPeriodId,
          studentId: studentId,
          type: type,
          name: name,
          gender: gender,
          birthPlace: birthPlace,
          birthDate: birthDate,
          nik: nik,
          religion: religion,
          childNumber: childNumber,
          fatherName: fatherName,
          motherName: motherName,
          parentJob: parentJob,
          address: address,
          phone: phone,
          birthDocumentFile: birthDocumentFile,
          registrationFormFile: registrationFormFile,
          availabilityFile: availabilityFile,
          profOfPaymentFile: profOfPaymentFile,
        );
        if (result.message == 'OK') {
          return const Right(true);
        } else {
          return Left(ServerFailure(message: result.message));
        }
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
