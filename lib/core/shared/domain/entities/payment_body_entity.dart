import 'package:equatable/equatable.dart';

import 'payment_detail_entity.dart';

class PaymentBody extends Equatable {
  final int studentId;
  final int total;
  final List<PaymentDetail> paymentDetails;

  const PaymentBody({required this.studentId, required this.total, required this.paymentDetails});

  @override
  List<Object?> get props => [
        studentId,
        total,
        paymentDetails,
      ];

  Map<String, dynamic> toJson() => {
        'siswa_id': studentId,
        'total': total,
        'rincian_pembayaran': paymentDetails.map((e) => e.toJson()).toList()
      };
}
