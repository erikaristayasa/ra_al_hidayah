import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

class GradeButton extends StatelessWidget {
  final VoidCallback onTap;
  final int quota;
  final String title;
  final Color backgroundColor;
  const GradeButton({
    Key? key,
    required this.onTap,
    required this.quota,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 20.0,
      height: 80,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.small),
      child: Row(
        children: [
          AppHelpers.smallHorizontalSpacing(),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppAssets.iconChildrenBG,
                  color: backgroundColor.darken(0.1),
                ),
                Center(
                  child: Image.asset(
                    AppAssets.iconChildren,
                  ),
                ),
              ],
            ),
          ),
          AppHelpers.smallHorizontalSpacing(),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Kuota Tersisa: $quota',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.polygon1,
                        color: backgroundColor.lighten(),
                        height: 24,
                        fit: BoxFit.fitHeight,
                      ),
                      SvgPicture.asset(
                        AppAssets.polygon2,
                        color: backgroundColor.lighten(),
                        height: 12,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: RoundedContainer(
                    width: 68.0,
                    color: backgroundColor,
                    shadow: true,
                    shadowBlurRadius: 8,
                    shadowSpreadRadius: 4,
                    shadowColor: Colors.black.withOpacity(0.1),
                    shadowOffset: const Offset(0, 0),
                    child: const Center(
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox.expand())
              ],
            ),
          )
        ],
      ),
    );
  }
}
