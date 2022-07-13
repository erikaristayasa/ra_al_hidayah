import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? customAction;
  const CustomBackButton({Key? key, this.customAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: AppDimensions.medium),
        height: 27.0,
        width: 27.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AppColors.primary.withOpacity(0.15),
        ),
        child: IconButton(
          splashRadius: 20.0,
          padding: const EdgeInsets.all(0.0),
          onPressed: () => customAction != null ? customAction!() : Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 14.0,
          ),
        ),
      ),
    );
  }
}
