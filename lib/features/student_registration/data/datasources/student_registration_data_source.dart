import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/statics/statics.dart';
import '../models/registration_period_response_model.dart';
import '../models/student_registration_reponse_model.dart';

abstract class StudentRegistrationDataSource {
  Future<RegistrationPeriodResponseModel> checkRegistrationPeriod();
  Future<StudentRegistrationResponseModel> create({
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
    required File? birthDocumentFile,
    required File? registrationFormFile,
    required File? availabilityFile,
    required File? profOfPaymentFile,
    required bool isDraft,
    required bool isUpdate,
  });
}

class StudentRegistrationDataSourceImplementation implements StudentRegistrationDataSource {
  final Dio dio;

  StudentRegistrationDataSourceImplementation({required this.dio});

  @override
  Future<RegistrationPeriodResponseModel> checkRegistrationPeriod() async {
    const path = 'api/orang-tua/pendaftaran-siswa/check-status';
    try {
      dio.withToken();
      final response = await dio.get(path);
      return RegistrationPeriodResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StudentRegistrationResponseModel> create({
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
    required File? birthDocumentFile,
    required File? registrationFormFile,
    required File? availabilityFile,
    required File? profOfPaymentFile,
    required bool isDraft,
    required bool isUpdate,
  }) async {
    String path = '';
    if (isUpdate) {
      path = 'api/orang-tua/pendaftaran-siswa/update/$studentId';
    } else {
      path = 'api/orang-tua/pendaftaran-siswa/create';
    }
    
    final body = {
      'jadwal_pendaftaran_id': registrationPeriodId,
      if (studentId != null) 'siswa_id': studentId,
      if (type != null) 'tipe': type,
      if (name != null) 'nama_lengkap': name,
      if (gender != null) 'jenis_kelamin': gender,
      if (birthPlace != null) 'tempat_lahir': birthPlace,
      if (birthDate != null) 'tanggal_lahir': birthDate,
      if (nik != null) 'nik': nik,
      if (religion != null) 'agama': religion,
      if (childNumber != null) 'anak_ke': childNumber,
      if (fatherName != null) 'nama_ayah': fatherName,
      if (motherName != null) 'nama_ibu': motherName,
      if (parentJob != null) 'pekerjaan_ayah_ibu': parentJob,
      if (address != null) 'alamat': address,
      if (phone != null) 'telepon': phone,
      if (birthDocumentFile != null) 'file_akta_kelahiran': await MultipartFile.fromFile(birthDocumentFile.path),
      if (registrationFormFile != null) 'file_berkas_form_pendaftaran': await MultipartFile.fromFile(registrationFormFile.path),
      if (availabilityFile != null) 'file_berkas_lembar_kesediaan': await MultipartFile.fromFile(availabilityFile.path),
      if (profOfPaymentFile != null) 'file_bukti_pembayaran': await MultipartFile.fromFile(profOfPaymentFile.path),
      'status': isDraft ? 'DRAFT' : 'DIPROSES'
    };

    AppHelpers.logMe(body);

    final data = FormData.fromMap(body);

    try {
      dio.withToken();
      final response = await dio.post(path, data: data);
      return StudentRegistrationResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
