import 'package:equatable/equatable.dart';
import '../../../statics/statics.dart';

class PaymentData extends Equatable {
  final PaymentStatus status;
  final int paymentId;

  const PaymentData({required this.status, required this.paymentId});

  @override
  List<Object?> get props => [status, paymentId];
}
