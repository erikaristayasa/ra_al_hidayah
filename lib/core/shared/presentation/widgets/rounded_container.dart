import 'package:flutter/material.dart';

import '../../../statics/statics.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final double radius;
  final bool shadow;
  final double? shadowSpreadRadius;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final Clip clipBerhaviour;
  const RoundedContainer({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.height,
    this.radius = AppDimensions.small,
    this.shadow = false,
    this.shadowSpreadRadius,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.shadowColor,
    this.padding = const EdgeInsets.all(AppDimensions.small),
    this.clipBerhaviour = Clip.none,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      clipBehavior: clipBerhaviour,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          (shadow)
              ? BoxShadow(
                  color: shadowColor ?? Colors.grey.withOpacity(0.3),
                  spreadRadius: shadowSpreadRadius ?? 2,
                  blurRadius: shadowBlurRadius ?? 5,
                  offset: shadowOffset ?? const Offset(0, 2),
                  blurStyle: BlurStyle.normal,
                )
              : const BoxShadow(color: Colors.transparent)
        ],
      ),
      child: child,
    );
  }
}
