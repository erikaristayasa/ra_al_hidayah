import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class RekeningInfo extends StatelessWidget {
  const RekeningInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: AppDimensions.large),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.textFieldGrey, width: 2.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppAssets.iconBank),
          const Text(
            'BANK MUAMALAT',
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const Text(
            'Norek.1110007133',
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w700,
              color: AppColors.textGrey,
            ),
          ),
          const Text(
            'A.n. Isnayani',
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
