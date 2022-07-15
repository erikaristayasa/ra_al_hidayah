import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/do_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DoLogin doLogin;
  LoginBloc({required this.doLogin}) : super(LoginInitial()) {
    on<Submit>((event, emit) async {
      emit(LoginLoading());

      final result = await doLogin(
        phone: event.phone,
        password: event.password,
      );

      result.fold(
        (failure) => emit(LoginFailure(failure: failure)),
        (data) => emit(LoginSuccess(data: data)),
      );
    });
  }
}
