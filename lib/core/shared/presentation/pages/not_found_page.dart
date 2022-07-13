import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../statics/statics.dart';

class NotFoundPage extends StatelessWidget {
  final bool enableBack;
  const NotFoundPage({Key? key, this.enableBack = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                AppAssets.lottieNotFound,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
