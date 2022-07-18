part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class InsertItem extends CartEvent {
  final PaymentDetail data;

  const InsertItem({required this.data});
  @override
  List<Object> get props => [data];
}

class RemoveItem extends CartEvent {
  final PaymentDetail data;

  const RemoveItem({required this.data});
  @override
  List<Object> get props => [data];
}

class AddSppMonths extends CartEvent {
  final List<int> months;
  final int nominal;

  const AddSppMonths({required this.months, required this.nominal});

  @override
  List<Object> get props => [months, nominal];
}
