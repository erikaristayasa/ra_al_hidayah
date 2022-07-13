import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class PageDescription extends StatelessWidget {
  final String title;
  final String description;
  final Widget? descriptionWidget;
  const PageDescription({
    Key? key,
    required this.title,
    required this.description,
    this.descriptionWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.medium,
        // horizontal: AppDimensions.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: AppColors.primary,
              height: 1.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          descriptionWidget != null
              ? descriptionWidget!
              : Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
        ],
      ),
    );
  }
}
