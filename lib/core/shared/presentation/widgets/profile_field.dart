import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';

class ProfileField extends StatelessWidget {
  final bool canBeCopied;
  final String title;
  final String value;
  const ProfileField({
    Key? key,
    this.canBeCopied = false,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.medium,
            top: AppDimensions.small,
            bottom: AppDimensions.xSmall,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: AppColors.textGrey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 8,
              child: RoundedContainer(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.xSmall),
                color: AppColors.textFieldGrey,
                height: 38.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: AppDimensions.medium - 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            canBeCopied
                ? Padding(
                    padding: const EdgeInsets.only(left: AppDimensions.small),
                    child: GestureDetector(
                      onTap: () => Clipboard.setData(
                        ClipboardData(text: value),
                      ).then(
                        (value) => Fluttertoast.showToast(
                          msg: "berhasil copy!",
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          textColor: AppColors.primary,
                        ),
                      ),
                      child: RoundedContainer(
                        height: 38.0,
                        width: 38.0,
                        color: AppColors.primary.withOpacity(0.15),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.iconCopy,
                            height: 16.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
