import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/shared/presentation/widgets/page_info.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/registration_bloc.dart';
import '../widgets/registration_form.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<RegistrationBloc>(),
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              AppHelpers.mediumVerticalSpacing(),
              Image.asset(
                AppAssets.logo,
                width: 80.0,
                height: 80.0,
              ),
              const PageInfo(
                title: 'Registrasi',
                description: 'Silahkan melakukan Registrasi jika belum memiliki akun.',
              ),
              const RegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
