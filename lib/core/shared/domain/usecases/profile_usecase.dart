import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../errors/failure.dart';
import '../entities/user_entity.dart';

abstract class GetProfileUseCase<Type> {
  Future<Either<Failure, User>> call();
}

abstract class UpdateProfileUseCase<Type> {
  Future<Either<Failure, bool>> call({
    String? nimNip,
    String? nidn,
    String? name,
    String? email,
    String? instance,
    String? degree,
    String? generation,
    XFile? photo,
  });
}
