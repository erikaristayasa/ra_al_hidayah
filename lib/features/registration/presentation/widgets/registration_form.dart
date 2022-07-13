import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/custom_password_container.dart';
import '../../../../core/shared/presentation/widgets/custom_text_field.dart';
import '../../../../core/shared/presentation/widgets/notification_label.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/registration_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case RegistrationLoading:
            context.loaderOverlay.show();
            break;
          case RegistrationFailure:
            context.loaderOverlay.hide();
            break;
          case RegistrationSuccess:
            context.loaderOverlay.hide();
            Future.delayed(const Duration(milliseconds: 1300), () {
              Navigator.pop(context);
            });
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  String _message = '';
                  bool? _isSuccess;
                  switch (state.runtimeType) {
                    case RegistrationFailure:
                      _isSuccess = false;
                      _message = AppHelpers.getErrorMessage((state as RegistrationFailure).failure);
                      break;
                    case RegistrationSuccess:
                      _isSuccess = true;
                      _message = 'Pendaftaran berhasil.';
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
              CustomTextField(controller: _parentNameController, placeholder: 'Nama Orang Tua', inputType: TextInputType.name),
              AppHelpers.smallVerticalSpacing(),
              CustomTextField(
                controller: _addressController,
                placeholder: 'Alamat',
                inputType: TextInputType.streetAddress,
                maxlines: 5,
              ),
              AppHelpers.smallVerticalSpacing(),
              CustomTextField(
                controller: _phoneController,
                placeholder: 'Nomor HP',
                inputType: TextInputType.phone,
                typeField: TypeField.phone,
              ),
              AppHelpers.smallVerticalSpacing(),
              CustomPasswordContainer(
                passwordController: _passwordController,
                passwordConfirmationController: _passwordConfirmationController,
                showDescriptionText: false,
              ),
              AppHelpers.largeVerticalSpacing(),
              RoundedButton(
                title: 'Registrasi',
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppPaths.login,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
