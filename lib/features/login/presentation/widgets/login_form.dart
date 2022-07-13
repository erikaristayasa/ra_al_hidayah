import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/custom_text_field.dart';
import '../../../../core/shared/presentation/widgets/notification_label.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoginLoading:
            context.loaderOverlay.show();
            break;
          case LoginFailure:
            context.loaderOverlay.hide();
            break;
          case LoginSuccess:
            context.loaderOverlay.hide();
            Navigator.pushReplacementNamed(context, AppPaths.main);
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  String _message = '';
                  bool? _isSuccess;
                  switch (state.runtimeType) {
                    case LoginFailure:
                      _isSuccess = false;
                      _message = AppHelpers.getErrorMessage((state as LoginFailure).failure);
                      break;
                    case LoginSuccess:
                      _isSuccess = true;
                      _message = '';
                      break;
                    default:
                      break;
                  }
                  if (_isSuccess != null) {
                    return NotificationLabel(
                      isSuccess: _isSuccess,
                      message: _message,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              CustomTextField(
                controller: _phoneController,
                placeholder: 'Nomor HP',
                inputType: TextInputType.phone,
              ),
              AppHelpers.smallVerticalSpacing(),
              CustomTextField(
                isSecure: true,
                controller: _passwordController,
                placeholder: 'Kata Sandi',
                inputType: TextInputType.visiblePassword,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppPaths.forgotPassword);
                    },
                    child: const Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
              RoundedButton(
                title: 'Login',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(Submit(
                          phone: _phoneController.text,
                          password: _passwordController.text,
                        ));
                  }
                },
              ),
              Visibility(
                visible: true, // TODO: check account type
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppPaths.register);
                      },
                      child: const Text(
                        'Registrasi.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
