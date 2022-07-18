import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/usecases/update_payment.dart';

part 'update_payment_event.dart';
part 'update_payment_state.dart';

class UpdatePaymentBloc extends Bloc<UpdatePaymentEvent, UpdatePaymentState> {
  final UpdatePayment updatePayment;
  UpdatePaymentBloc({required this.updatePayment}) : super(UpdatePaymentInitial()) {
    on<Submit>((event, emit) async {
      emit(UpdatePaymentLoading());

      final result = await updatePayment(file: event.file, id: event.id);
      result.fold(
        (failure) => emit(UpdatePaymentFailure(failure: failure)),
        (_) => emit(UpdatePaymentUpdated()),
      );
    });
  }
}
