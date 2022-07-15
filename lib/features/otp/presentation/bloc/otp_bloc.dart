import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/validate_otp.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final ValidateOtp validateOtp;
  OtpBloc({required this.validateOtp}) : super(OtpInitial()) {
    on<Validate>((event, emit) async {
      emit(OtpLoading());

      final result = await validateOtp(token: event.token, code: event.code);
      result.fold(
        (failure) => emit(OtpInvalid(failure: failure)),
        (_) => emit(OtpValid()),
      );
    });
  }
}
