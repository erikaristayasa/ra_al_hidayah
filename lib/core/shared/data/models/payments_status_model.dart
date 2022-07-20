import '../../domain/entities/payment_status_entity.dart';
import 'payment_data_model.dart';

class PaymentsStatusModel extends PaymentsStatus {
  const PaymentsStatusModel({
    required PaymentDataModel? activity,
    required PaymentDataModel? stationary,
    required PaymentDataModel? uniform,
    required PaymentDataModel? hood,
    required PaymentDataModel? buildingMoney,
    required SPPModel spp,
  }) : super(
          activity: activity,
          stationary: stationary,
          uniform: uniform,
          hood: hood,
          buildingMoney: buildingMoney,
          spp: spp,
        );
  factory PaymentsStatusModel.fromJson(Map<String, dynamic> json) => PaymentsStatusModel(
        activity: json['kegiatan'] != null ? PaymentDataModel.fromJson(json['kegiatan']) : null,
        stationary: json['alat_tulis_dan_buku_paket'] != null ? PaymentDataModel.fromJson(json['alat_tulis_dan_buku_paket']) : null,
        uniform: json['seragam_5_stel'] != null ? PaymentDataModel.fromJson(json['seragam_5_stel']) : null,
        hood: json['kerudung'] != null ? PaymentDataModel.fromJson(json['kerudung']) : null,
        buildingMoney: json['uang_bangunan'] != null ? PaymentDataModel.fromJson(json['uang_bangunan']) : null,
        spp: SPPModel.fromJson(json['spp']),
      );
}

class SPPModel extends SPP {
  const SPPModel({
    required PaymentDataModel? january,
    required PaymentDataModel? february,
    required PaymentDataModel? march,
    required PaymentDataModel? april,
    required PaymentDataModel? may,
    required PaymentDataModel? june,
    required PaymentDataModel? july,
    required PaymentDataModel? august,
    required PaymentDataModel? september,
    required PaymentDataModel? october,
    required PaymentDataModel? november,
    required PaymentDataModel? december,
  }) : super(
          january: january,
          february: february,
          march: march,
          april: april,
          may: may,
          june: june,
          july: july,
          august: august,
          september: september,
          october: october,
          november: november,
          december: december,
        );
  factory SPPModel.fromJson(Map<String, dynamic> json) => SPPModel(
        january: json['januari'] != null ? PaymentDataModel.fromJson(json['januari']) : null,
        february: json['februari'] != null ? PaymentDataModel.fromJson(json['februari']) : null,
        march: json['maret'] != null ? PaymentDataModel.fromJson(json['maret']) : null,
        april: json['april'] != null ? PaymentDataModel.fromJson(json['april']) : null,
        may: json['mei'] != null ? PaymentDataModel.fromJson(json['mei']) : null,
        june: json['juni'] != null ? PaymentDataModel.fromJson(json['juni']) : null,
        july: json['juli'] != null ? PaymentDataModel.fromJson(json['juli']) : null,
        august: json['agustus'] != null ? PaymentDataModel.fromJson(json['agustus']) : null,
        september: json['september'] != null ? PaymentDataModel.fromJson(json['september']) : null,
        october: json['oktober'] != null ? PaymentDataModel.fromJson(json['oktober']) : null,
        november: json['november'] != null ? PaymentDataModel.fromJson(json['november']) : null,
        december: json['desember'] != null ? PaymentDataModel.fromJson(json['desember']) : null,
      );
}
