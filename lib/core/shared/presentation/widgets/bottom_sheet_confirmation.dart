import 'rounded_button.dart';
import 'slide_up_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';

class BottomSheetConfirmation extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  const BottomSheetConfirmation({
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.iconQuestion,
                  height: 70.0,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                  child: Text(
                    message,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.large,
              vertical: AppDimensions.small
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Tidak',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
                RoundedButton(
                  onTap: onConfirm,
                  title: 'Ya',
                  width: 90.0,
                  height: 30.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
