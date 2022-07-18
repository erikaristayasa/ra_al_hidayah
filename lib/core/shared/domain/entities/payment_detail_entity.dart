import 'package:equatable/equatable.dart';

import '../../../statics/statics.dart';

class PaymentDetail extends Equatable {
  final PaymentType type;
  final int nominal;
  final int? month;

  const PaymentDetail({required this.type, required this.nominal, this.month});

  @override
  List<Object?> get props => [
        type,
        nominal,
        month,
      ];

  Map<String, dynamic> toJson() => {
        'tipe': type.text,
        'nominal': nominal,
        if (month != null) 'bulan': month,
      };
}
