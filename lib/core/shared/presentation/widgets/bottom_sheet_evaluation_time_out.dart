import 'package:flutter/material.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';
import 'rounded_button.dart';
import 'slide_up_indicator.dart';

class BottomSheetEvaluationTimeOut extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  const BottomSheetEvaluationTimeOut({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 244,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.medium),
          topRight: Radius.circular(AppDimensions.medium),
        ),
      ),
      child: Column(
        children: [
          const SlideUpIndicator(),
          Expanded(
            child: Column(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 36.0,
                ),
                AppHelpers.mediumVerticalSpacing(),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  message,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.large,
              vertical: AppDimensions.medium,
            ),
            child: RoundedButton(
              onTap: onConfirm,
              title: 'Submit',
              width: 90.0,
              height: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
