import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/do_forgot_password.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final DoForgotPassword doForgotPassword;
  ForgotPasswordBloc({required this.doForgotPassword}) : super(ForgotPasswordInitial()) {
    on<Submit>((event, emit) async {
      emit(ForgotPasswordLoading());

      final result = await doForgotPassword(event.phone);
      result.fold(
        (failure) => emit(ForgotPasswordFailure(failure: failure)),
        (token) => emit(ForgotPasswordSuccess(token: token)),
      );
    });
  }
}
