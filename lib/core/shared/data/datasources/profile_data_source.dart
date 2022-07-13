import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';
import '../models/profile_response_model.dart';
import '../models/profile_update_response_model.dart';

abstract class ProfileDataSource {
  Future<ProfileResponseModel> getLectureProfile();
  Future<ProfileUpdateResponseModel> updateLectureProfile({
    String? nimNip,
    String? nidn,
    String? name,
    String? email,
    String? instance,
    XFile? photo,
  });
  Future<ProfileResponseModel> getStudentProfile();
  Future<ProfileUpdateResponseModel> updateStudentProfile({
    String? nimNip,
    String? name,
    String? email,
    String? degree,
    String? generation,
    XFile? photo,
  });
}

class ProfileDataSourceImplementation implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImplementation({required this.dio});

  @override
  Future<ProfileResponseModel> getLectureProfile() async {
    late String path;
    final _accountTypeFromSession = await AppHelpers.getAccountTypeFromSession();
    if (_accountTypeFromSession == AccountType.lecturer) {
      path = 'api/dosen/profile';
    } else {
      path = 'api/mahasiswa/profile/dosen';
    }
    try {
      dio.withToken();
      final response = await dio.get(path);
      return ProfileResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileUpdateResponseModel> updateLectureProfile({
    String? nimNip,
    String? nidn,
    String? name,
    String? email,
    String? instance,
    XFile? photo,
  }) async {
    const String path = 'api/dosen/profile/update';
    try {
      final map = {
        if (nimNip != null) 'nim_nip': nimNip,
        if (nidn != null) 'nidn': nidn,
        if (name != null) 'nama': name,
        if (email != null) 'email': email,
        if (instance != null) 'instansi': instance,
        if (photo != null) 'foto': await MultipartFile.fromFile(photo.path, filename: photo.name),
      };
      final data = FormData.fromMap(map);
      dio.withToken();
      final response = await dio.post(path, data: data);
      return ProfileUpdateResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileResponseModel> getStudentProfile() async {
    const path = 'api/mahasiswa/profile';

    try {
      dio.withToken();
      final response = await dio.get(path);
      return ProfileResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileUpdateResponseModel> updateStudentProfile({
    String? nimNip,
    String? name,
    String? email,
    String? degree,
    String? generation,
    XFile? photo,
  }) async {
    const String path = 'api/dosen/profile/update';
    try {
      final map = {
        if (nimNip != null) 'nim_nip': nimNip,
        if (name != null) 'nama': name,
        if (email != null) 'email': email,
        if (degree != null) 'kelas': degree,
        if (generation != null) 'angkatan': generation,
        if (photo != null) 'foto': await MultipartFile.fromFile(photo.path, filename: photo.name),
      };
      final data = FormData.fromMap(map);
      dio.withToken();
      final response = await dio.post(path, data: data);
      return ProfileUpdateResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
