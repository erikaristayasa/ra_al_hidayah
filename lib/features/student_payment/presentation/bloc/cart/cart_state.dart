part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  // final PaymentDetail activity;
  // final PaymentDetail uniform;
  // final PaymentDetail spp;
  // final PaymentDetail activity;
  // final PaymentDetail activity;
  // final List<int> selectedMonth;
  final List<PaymentDetail> paymentDetails;
  const CartState({required this.paymentDetails});

  @override
  List<Object> get props => [paymentDetails];
}

class CartInitial extends CartState {
  const CartInitial({
    required List<PaymentDetail> paymentDetails,
  }) : super(
          paymentDetails: paymentDetails,
        );
}
