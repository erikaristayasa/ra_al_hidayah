import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';

class EmptyStudentsBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  const EmptyStudentsBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.medium),
          topRight: Radius.circular(AppDimensions.medium),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppHelpers.largeVerticalSpacing(),
                SvgPicture.asset(
                  AppAssets.illustrationError,
                  height: 150,
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
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large, vertical: AppDimensions.small),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Nanti',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
                RoundedButton(
                  onTap: onConfirm,
                  title: 'Daftar',
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
