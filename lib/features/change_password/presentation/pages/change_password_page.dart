import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/custom_password_container.dart';
import '../../../../core/shared/presentation/widgets/page_info.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/change_password_bloc.dart';

class ChangePasswordPageRouteArguments {
  final String token;
  final AccountType type;

  ChangePasswordPageRouteArguments({required this.token, required this.type});
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ChangePasswordBloc>(),
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              const PageInfo(
                title: 'Ubah Kata Sandi',
                description: 'Silahkan ubah kata sandi baru sesuai keinginan Anda.',
                asset: AppAssets.illustrationChangePassword,
              ),
              BlocListener<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ChangePasswordLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                    if (state is ChangePasswordSuccess) {
                      Navigator.pushReplacementNamed(context, AppPaths.login);
                    } else if (state is ChangePasswordFailure) {
                      final _failure = state.failure;
                      Fluttertoast.showToast(msg: AppHelpers.getErrorMessage(_failure));
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomPasswordContainer(
                          showDescriptionText: false,
                          passwordController: _passwordController,
                          passwordConfirmationController: _passwordConfirmationController,
                        ),
                        AppHelpers.largeVerticalSpacing(),
                        RoundedButton(
                          title: 'Ubah',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(context, AppPaths.login);
                              // Navigator.pushReplacementNamed(context, AppPaths.verificationSuccess);
                              // context.read<ChangePasswordBloc>().add(Submit(
                              //       password: _passwordController.text,
                              //       passwordConfirmation: _passwordConfirmationController.text,
                              //       type: widget.type,
                              //       token: widget.token,
                              //     ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
