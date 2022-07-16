import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/change_password.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;
  ChangePasswordBloc({required this.changePassword}) : super(ChangePasswordInitial()) {
    on<Submit>((event, emit) async {
      emit(ChangePasswordLoading());

      final result = await changePassword(
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
        token: event.token,
      );

      result.fold(
        (failure) => emit(ChangePasswordFailure(failure: failure)),
        (_) => emit(ChangePasswordSuccess()),
      );
    });
  }
}
