import '../../../statics/statics.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String email,
    required String name,
    required String phone,
    required String address,
    required AccountType accountType,
  }) : super(
          id: id,
          email: email,
          name: name,
          phone: phone,
          address: address,
          accountType: accountType,
        );
  

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'] ?? '',
        name: json['nama'] ?? '',
        phone: json['telepon'] ?? '',
        address: json['alamat'] ?? '',
        accountType: (json['role'] as String).getAccountType,
      );
}

