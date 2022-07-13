import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String message;
  final bool center;
  const EmptyPage({
    Key? key,
    this.title = '',
    this.message = '',
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Builder(builder: (context) {
            if (center) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.illustrationEmpty,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.illustrationEmpty,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
