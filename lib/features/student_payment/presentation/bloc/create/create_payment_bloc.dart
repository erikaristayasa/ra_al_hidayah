import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../../../domain/usecases/create_payment.dart';

part 'create_payment_event.dart';
part 'create_payment_state.dart';

class CreatePaymentBloc extends Bloc<CreatePaymentEvent, CreatePaymentState> {
  final CreatePayment createPayment;
  CreatePaymentBloc({required this.createPayment}) : super(CreatePaymentInitial()) {
    on<Submit>((event, emit) async {
      emit(CreatePaymentLoading());

      final result = await createPayment(event.body);
      result.fold(
        (failure) => emit(CreatePaymentFailure(failure: failure)),
        (id) => emit(CreatePaymentCreated(id: id)),
      );
    });
  }
}
