import 'package:flutter/material.dart';

import '../../../statics/statics.dart';
import 'rounded_container.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.large,
        vertical: AppDimensions.medium,
      ),
      child: RoundedContainer(
        padding: const EdgeInsets.all(0.0),
        radius: 15.0,
        height: 42,
        color: AppColors.primary.withOpacity(0.3),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.textGrey,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
