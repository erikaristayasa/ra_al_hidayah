import '../../domain/entities/registration_period_entity.dart';

class RegistrationPeriodModel extends RegistrationPeriod {
  const RegistrationPeriodModel({
    required int id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required int quotaTkA,
    required int quotaTkB,
    required int quotaPlaygroup,
    required String fileRegistrationForm,
    required String fileAvailability,
    required bool status,
  }) : super(
          id: id,
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          quotaTkA: quotaTkA,
          quotaTkB: quotaTkB,
          quotaPlaygroup: quotaPlaygroup,
          fileRegistrationForm: fileRegistrationForm,
          fileAvailability: fileAvailability,
          status: status,
        );

  factory RegistrationPeriodModel.fromJson(Map<String, dynamic> json) => RegistrationPeriodModel(
        id: json['id'],
        title: json['judul'] ?? '',
        description: json['deskripsi'] ?? '',
        startDate: DateTime.parse(json['tanggal_mulai']),
        endDate: DateTime.parse(json['tanggal_selesai']),
        quotaTkA: json['kuota_tk_a'],
        quotaTkB: json['kuota_tk_b'],
        quotaPlaygroup: json['kuota_playgroup'],
        fileRegistrationForm: json['file_berkas_form_pendaftaran'] ?? '',
        fileAvailability: json['file_berkas_lembar_kesediaan'] ?? '',
        status: json['status'],
      );
}
