import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:flutter/material.dart';

class SlideUpIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const SlideUpIndicator({
    Key? key,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppDimensions.medium,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      height: 6.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey,
      ),
    );
  }
}
