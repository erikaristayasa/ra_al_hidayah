import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/shared/domain/entities/payment_detail_entity.dart';
import '../../../../../core/statics/statics.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial(paymentDetails: [])) {
    on<InsertItem>((event, emit) async {
      final _newData = event.data;
      List<PaymentDetail> _items = List<PaymentDetail>.from(state.paymentDetails);
      if (_items.contains(_newData)) {
        _items.remove(_newData);
      } else {
        _items.add(_newData);
      }
      emit(CartInitial(paymentDetails: _items));
    });

    // on<RemoveItem>((event, emit) async {
    //   final _data = event.data;
    //   final _listData = state.paymentDetails;
    //   _listData.remove(_data);
    //   emit(CartInitial(paymentDetails: _listData));
    // });

    on<AddSppMonths>((event, emit) async {
      List<PaymentDetail> _items = List<PaymentDetail>.from(state.paymentDetails);
      final _months = event.months;
      for (var month in _months) {
        final _newItem = PaymentDetail(
          type: PaymentType.spp,
          nominal: event.nominal,
          month: month,
        );
        if (!_items.contains(_newItem)) {
          _items.add(_newItem);
        }
      }

      emit(CartInitial(paymentDetails: _items));
    });
  }
}
