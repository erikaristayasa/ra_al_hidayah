import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/page_info.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../forgot_password/presentation/bloc/forgot_password_bloc.dart';
import '../bloc/otp_bloc.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late String _token;
  final _otpBloc = locator<OtpBloc>();
  final _forgotBloc = locator<ForgotPasswordBloc>();
  final _pinController = TextEditingController();
  bool _resent = false;
  CountdownTimerController? _timerController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _otpBloc,
        ),
        BlocProvider(
          create: (context) => _forgotBloc,
        ),
      ],
      child: LoaderOverlay(
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
              if (state is ForgotPasswordSuccess) {
                _pinController.clear();
                setState(() {
                  _token = state.token;
                  _resent = true;
                  _timerController = CountdownTimerController(
                      endTime: DateTime.now().add(const Duration(seconds: 30)).millisecondsSinceEpoch,
                      onEnd: () {
                        setState(() {
                          _resent = false;
                        });
                      });
                  _timerController?.start();
                });
              }
            }
          },
          child: BlocListener<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is OtpLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
                if (state is OtpValid) {
                  Fluttertoast.showToast(msg: 'Verified');
                  Navigator.pushReplacementNamed(context, AppPaths.changePassword);
                  // Navigator.popAndPushNamed(
                  //   context,
                  //   AppPaths.changePassword,
                  //   arguments: ChangePasswordPageRouteArguments(
                  //     token: _data.token,
                  //     type: widget.prevType,
                  //   ),
                  // );
                } else if (state is OtpInvalid) {
                  _pinController.clear();
                  Fluttertoast.showToast(msg: AppHelpers.getErrorMessage(state.failure));
                }
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                shrinkWrap: true,
                children: [
                  const PageInfo(
                    title: 'Verifikasi Kode OTP',
                    description: 'Masukkan 4 digit kode verifikasi',
                    asset: AppAssets.illustrationOTP,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _timerController != null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: AppDimensions.medium, right: AppDimensions.medium),
                                child: CountdownTimer(
                                  endWidget: const SizedBox.shrink(),
                                  widgetBuilder: (context, remaining) {
                                    if (remaining != null) {
                                      return Text(
                                        '00:${remaining.sec}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                          color: AppColors.textGrey,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                  controller: _timerController,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Pinput(
                    controller: _pinController,
                    defaultPinTheme: const PinTheme(
                      width: 45.0,
                      height: 45.0,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                      padding: EdgeInsets.all(AppDimensions.small),
                      margin: EdgeInsets.all(AppDimensions.medium),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primary,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    onCompleted: (code) {
                      AppHelpers.logMe('TOKEN: $_token');
                      AppHelpers.logMe('CODE: $code');
                      // _otpBloc.add(otp.Submit(token: _data.token, code: code));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.large),
                    child: !_resent
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Tidak menerima kode?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // _forgotBloc.add(Submit(
                                  //   nim: widget.prevNim,
                                  //   type: widget.prevType,
                                  // ));
                                },
                                child: const Text(
                                  ' Kirim Ulang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                    child: RoundedButton(
                      radius: 15.0,
                      title: 'Verifikasi',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppPaths.changePassword);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
