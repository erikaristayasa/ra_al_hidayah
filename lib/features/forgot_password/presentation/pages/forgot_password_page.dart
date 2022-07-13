import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/custom_text_field.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_button.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/notification_label.dart';
import '../../../../core/shared/presentation/widgets/page_info.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ForgotPasswordBloc>(),
        ),
      ],
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              const PageInfo(
                title: 'Lupa Kata Sandi',
                description: 'Masukkan Nomor HP yang pernah terdaftar untuk melanjutkan ubah kata sandi.',
                asset: AppAssets.illustrationForgotPassword,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) async {
                    if (state is ForgotPasswordLoading) {
                      context.loaderOverlay.show();
                    } else {
                      context.loaderOverlay.hide();
                      if (state is ForgotPasswordSuccess) {}
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordSuccess) {
                    } else if (state is ForgotPasswordFailure) {
                      return NotificationLabel(isSuccess: false, message: AppHelpers.getErrorMessage(state.failure));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                  child: Column(
                    children: [
                      CustomTextField(
                        placeholder: 'Nomor HP',
                        controller: _phoneController,
                        inputType: TextInputType.phone,
                        typeField: TypeField.phone,
                      ),
                      AppHelpers.largeVerticalSpacing(),
                      RoundedButton(
                        title: 'Selanjutnya',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
