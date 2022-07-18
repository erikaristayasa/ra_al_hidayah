import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class BottomSheetCancelPayment extends StatelessWidget {
  const BottomSheetCancelPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.medium),
          topRight: Radius.circular(AppDimensions.medium),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  AppAssets.iconClose,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Yakin Batal Upload Bukti Transfer?',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                  ),
                ),
                const Text(
                  'Bukti transfer akan dihapus, Anda yakin?',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: AppColors.textGrey,
                  ),
                ),
                AppHelpers.mediumVerticalSpacing(),
                RoundedButton(
                  title: 'Lanjut Upload',
                  onTap: () => Navigator.pop(context),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ya, Batalkan',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, color: AppColors.textGrey),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
