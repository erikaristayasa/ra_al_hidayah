import 'package:ra_al_hidayah/core/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class NotificationLabel extends StatelessWidget {
  final bool isSuccess;
  final String message;

  const NotificationLabel({
    Key? key,
    required this.isSuccess,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.small, horizontal: AppDimensions.medium),
      margin: const EdgeInsets.only(bottom: AppDimensions.medium),
      // height: 35.0,
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.success : AppColors.error,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: (35 / 2) - AppDimensions.small,
            backgroundColor: Colors.white,
            child: Icon(
              isSuccess ? Icons.check : Icons.close,
              color: isSuccess ? AppColors.success : AppColors.error,
              size: 12.0,
            ),
          ),
          AppHelpers.smallHorizontalSpacing(),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
