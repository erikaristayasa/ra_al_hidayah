import 'package:equatable/equatable.dart';

import '../../../../core/shared/domain/entities/user_entity.dart';

class Login extends Equatable {
  final User user;
  final String token;

  const Login({required this.user, required this.token});
  @override
  List<Object?> get props => [user, token];
}
