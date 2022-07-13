import '../../../statics/statics.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String nimNip,
    required String email,
    required String? nidn,
    required String name,
    required String? grade,
    required String? generation,
    required String? instance,
    required String? course,
    required String photo,
    required AccountType accountType,
  }) : super(
          id: id,
          nimNip: nimNip,
          nidn: nidn,
          email: email,
          name: name,
          grade: grade,
          generation: generation,
          instance: instance,
          course: course,
          photo: photo,
          accountType: accountType,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        nimNip: json['nim_nip'],
        nidn: json['nidn'],
        email: json['email'],
        name: json['nama'],
        grade: json['kelas'],
        generation: json['angkatan'],
        instance: json['instansi'],
        course: json['mata_kuliah'],
        photo: json['foto'] ?? '',
        accountType: (json['role'] as String).getAccountType,
      );
}
