import 'package:equatable/equatable.dart';

import 'payment_data_entity.dart';

class PaymentsStatus extends Equatable {
  final PaymentData? activity;
  final PaymentData? stationary;
  final PaymentData? uniform;
  final PaymentData? hood;
  final PaymentData? buildingMoney;
  final SPP spp;

  const PaymentsStatus({
    required this.activity,
    required this.stationary,
    required this.uniform,
    required this.hood,
    required this.buildingMoney,
    required this.spp,
  });

  @override
  List<Object?> get props => [
        activity,
        stationary,
        uniform,
        hood,
        buildingMoney,
        spp,
      ];
}

class SPP extends Equatable {
  final PaymentData? january;
  final PaymentData? february;
  final PaymentData? march;
  final PaymentData? april;
  final PaymentData? may;
  final PaymentData? june;
  final PaymentData? july;
  final PaymentData? august;
  final PaymentData? september;
  final PaymentData? october;
  final PaymentData? november;
  final PaymentData? december;

  const SPP({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
  });

  PaymentData? getAt(int month) {
    switch (month) {
      case 1:
        return january;
      case 2:
        return february;
      case 3:
        return march;
      case 4:
        return april;
      case 5:
        return may;
      case 6:
        return june;
      case 7:
        return july;
      case 8:
        return august;
      case 9:
        return september;
      case 10:
        return october;
      case 11:
        return november;
      case 12:
      default:
        return december;
    }
  }

  @override
  List<Object?> get props => [
        january,
        february,
        march,
        april,
        may,
        june,
        july,
        august,
        september,
        october,
        november,
        december,
      ];
}
