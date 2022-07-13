import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';

class PageInfo extends StatelessWidget {
  final String title, description, asset;
  const PageInfo({
    Key? key,
    required this.title,
    required this.description,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.large),
      child: Column(
        children: [
          // app name
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Anatomi dan Fisiologi  ',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 16.0),
                    ),
                    TextSpan(
                      text: 'Manusia.',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ],
          ),
          AppHelpers.mediumVerticalSpacing(),

          // image
          SvgPicture.asset(
            asset,
            fit: BoxFit.fitWidth,
            height: 200.0,
          ),
          AppHelpers.largeVerticalSpacing(),

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
