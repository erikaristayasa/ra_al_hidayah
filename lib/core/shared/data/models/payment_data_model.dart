import '../../../statics/statics.dart';
import '../../domain/entities/payment_data_entity.dart';

class PaymentDataModel extends PaymentData {
  const PaymentDataModel({
    required PaymentStatus status,
    required int paymentId,
  }) : super(
          status: status,
          paymentId: paymentId,
        );
  factory PaymentDataModel.fromJson(Map<String, dynamic> json) => PaymentDataModel(
        status: (json['status'] as String).paymentStatus,
        paymentId: json['id'],
      );
}
