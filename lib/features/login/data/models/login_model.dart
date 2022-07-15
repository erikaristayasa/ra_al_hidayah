import '../../../../core/shared/data/models/user_model.dart';
import '../../domain/entities/login_entity.dart';

class LoginModel extends Login {
  const LoginModel({
    required UserModel user,
    required String token,
  }) : super(
          user: user,
          token: token,
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: UserModel.fromJson(json['user']),
        token: json['token'],
      );
}
