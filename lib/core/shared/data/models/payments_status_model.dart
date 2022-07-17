import '../../domain/entities/payment_status_entity.dart';
import '../../../statics/statics.dart';

class PaymentsStatusModel extends PaymentsStatus {
  const PaymentsStatusModel({
    required PaymentStatus? activity,
    required PaymentStatus? stationary,
    required PaymentStatus? uniform,
    required PaymentStatus? hood,
    required PaymentStatus? buildingMoney,
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
        activity: json['kegiatan'] != null ? (json['kegiatan'] as String).paymentStatus : null,
        stationary: json['alat_tulis_dan_buku_paket'] != null ? (json['alat_tulis_dan_buku_paket'] as String).paymentStatus : null,
        uniform: json['seragam_5_stel'] != null ? (json['seragam_5_stel'] as String).paymentStatus : null,
        hood: json['kerudung'] != null ? (json['kerudung'] as String).paymentStatus : null,
        buildingMoney: json['uang_bangunan'] != null ? (json['uang_bangunan'] as String).paymentStatus : null,
        spp: SPPModel.fromJson(json['spp']),
      );
}

class SPPModel extends SPP {
  const SPPModel({
    required PaymentStatus? january,
    required PaymentStatus? february,
    required PaymentStatus? march,
    required PaymentStatus? april,
    required PaymentStatus? may,
    required PaymentStatus? june,
    required PaymentStatus? july,
    required PaymentStatus? august,
    required PaymentStatus? september,
    required PaymentStatus? october,
    required PaymentStatus? november,
    required PaymentStatus? december,
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
        january: json['januari'] != null ? (json['januari'] as String).paymentStatus : null,
        february: json['februari'] != null ? (json['februari'] as String).paymentStatus : null,
        march: json['maret'] != null ? (json['maret'] as String).paymentStatus : null,
        april: json['april'] != null ? (json['april'] as String).paymentStatus : null,
        may: json['mei'] != null ? (json['mei'] as String).paymentStatus : null,
        june: json['juni'] != null ? (json['juni'] as String).paymentStatus : null,
        july: json['juli'] != null ? (json['juli'] as String).paymentStatus : null,
        august: json['agustus'] != null ? (json['agustus'] as String).paymentStatus : null,
        september: json['september'] != null ? (json['september'] as String).paymentStatus : null,
        october: json['oktober'] != null ? (json['oktober'] as String).paymentStatus : null,
        november: json['november'] != null ? (json['november'] as String).paymentStatus : null,
        december: json['desember'] != null ? (json['desember'] as String).paymentStatus : null,
      );
}
