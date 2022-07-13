import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../routes/routes.dart';
import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 800), () async {
    //   final session = await locator.getAsync<SharedPreferencesHelper>();
    //   if (session.isLoggedIn()) {
    //     Navigator.pushReplacementNamed(context, AppPaths.main);
    //   } else {
    //     Navigator.pushReplacementNamed(context, AppPaths.login);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
