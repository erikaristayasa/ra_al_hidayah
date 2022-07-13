import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';

class PageInfo extends StatelessWidget {
  final String title, description;
  final String? asset;
  const PageInfo({
    Key? key,
    required this.title,
    required this.description,
    this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.large),
      child: Column(
        children: [
          // app name

          // image
          asset != null
              ? Column(
                  children: [
                    SvgPicture.asset(
                      asset!,
                      fit: BoxFit.fitWidth,
                      height: 200.0,
                    ),
                    AppHelpers.largeVerticalSpacing(),
                  ],
                )
              : const SizedBox.shrink(),

          // title
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20.0),
          ),

          // description
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w400, fontSize: 14.0),
          ),
          AppHelpers.mediumVerticalSpacing(),
        ],
      ),
    );
  }
}
