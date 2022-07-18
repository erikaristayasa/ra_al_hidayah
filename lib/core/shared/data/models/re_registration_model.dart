import '../../domain/entities/re_registration_entity.dart';
import 'cost_breakdown_model.dart';

class ReRegistrationModel extends ReRegistration {
  const ReRegistrationModel({
    required int id,
    required int periodId,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required List<CostBreakdownModel> costBreakdowns,
  }) : super(
          id: id,
          periodId: periodId,
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          costBreakdowns: costBreakdowns,
        );
  factory ReRegistrationModel.fromJson(Map<String, dynamic> json) => ReRegistrationModel(
        id: json['id'],
        periodId: json['jadwal_pendaftaran_id'],
        title: json['judul'],
        description: json['deskripsi'],
        startDate: DateTime.parse(json['tanggal_mulai']),
        endDate: DateTime.parse(json['tanggal_selesai']),
        costBreakdowns: json['rincian_biaya'] != null
            ? List<CostBreakdownModel>.from(
                json['rincian_biaya'].map((x) => CostBreakdownModel.fromJson(x)),
              )
            : [],
      );
}
