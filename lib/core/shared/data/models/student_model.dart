import '../../../statics/statics.dart';
import '../../domain/entities/student_entity.dart';
import 'payments_status_model.dart';
import 'registration_period_model.dart';

class StudentModel extends Student {
  const StudentModel({
    required int id,
    required int parentId,
    required int periodId,
    required GradeType type,
    required String name,
    required Gender? gender,
    required String birthPlace,
    required DateTime? birthDate,
    required String nik,
    required String religion,
    required String childNumber,
    required String fatherName,
    required String motherName,
    required String parentJob,
    required String address,
    required String phone,
    required String fileBirthDocument,
    required String fileRegistrationForm,
    required String fileAvailability,
    required String fileProfOfPayment,
    required PaymentStatus status,
    required String rejectNote,
    required DateTime? endPaymentDate,
    required PaymentsStatusModel paymentsStatus,
    required RegistrationPeriodModel? registrationPeriod,
  }) : super(
          id: id,
          parentId: parentId,
          periodId: periodId,
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
          fileBirthDocument: fileBirthDocument,
          fileRegistrationForm: fileRegistrationForm,
          fileAvailability: fileAvailability,
          fileProfOfPayment: fileProfOfPayment,
          status: status,
          rejectNote: rejectNote,
          endPaymentDate: endPaymentDate,
          paymentsStatus: paymentsStatus,
          registrationPeriod: registrationPeriod,
        );

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json['id'],
        parentId: json['orang_tua_id'],
        periodId: json['jadwal_pendaftaran_id'],
        type: (json['tipe'] as String).gradeType,
        name: json['nama_lengkap'],
        gender: json['jenis_kelamin'] != null ? (json['jenis_kelamin'] as String).gender : null,
        birthPlace: json['tempat_lahir'] ?? '',
        birthDate: json['tanggal_lahir'] != null ? DateTime.parse(json['tanggal_lahir']) : null,
        nik: json['nik'] ?? '',
        religion: json['agama'] ?? '',
        childNumber: json['anak_ke'] != null ? json['anak_ke'].toString() : '',
        fatherName: json['nama_ayah'] ?? '',
        motherName: json['nama_ibu'] ?? '',
        parentJob: json['pekerjaan_ayah_ibu'] ?? '',
        address: json['alamat'] ?? '',
        phone: json['telepon'] ?? '',
        fileBirthDocument: json['file_akta_kelahiran'] ?? '',
        fileRegistrationForm: json['file_berkas_form_pendaftaran'] ?? '',
        fileAvailability: json['file_berkas_lembar_kesediaan'] ?? '',
        fileProfOfPayment: json['file_bukti_pembayaran'] ?? '',
        status: (json['status'] as String).paymentStatus,
        rejectNote: json['keterangan_ditolak'] ?? '',
        endPaymentDate: json['tanggal_terakhir_pembayaran'] != null ? DateTime.parse(json['tanggal_terakhir_pembayaran']) : null,
        paymentsStatus: PaymentsStatusModel.fromJson(json['status_pembayaran']),
        registrationPeriod: json['jadwal_pendaftaran'] != null ? RegistrationPeriodModel.fromJson(json['jadwal_pendaftaran']) : null,
      );
}
