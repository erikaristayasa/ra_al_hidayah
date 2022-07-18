part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<PaymentDetail> paymentDetails;
  const CartState({required this.paymentDetails});

  @override
  List<Object> get props => [paymentDetails];

  int get total {
    int _total = 0;
    for (var item in paymentDetails) {
      _total += item.nominal;
    }
    return _total;
  }

  int get sppTotal {
    int _total = 0;
    for (var item in paymentDetails) {
      if (item.type == PaymentType.spp) {
        _total += item.nominal;
      }
    }
    return _total;
  }
}

class CartInitial extends CartState {
  const CartInitial({
    required List<PaymentDetail> paymentDetails,
  }) : super(
          paymentDetails: paymentDetails,
        );
}
