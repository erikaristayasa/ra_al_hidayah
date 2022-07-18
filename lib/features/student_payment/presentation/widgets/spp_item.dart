import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class SppItem extends StatefulWidget {
  final String title;
  final int nominal;
  final VoidCallback? onChecked;
  final PaymentStatus? status;
  final bool checked;
  const SppItem({
    Key? key,
    required this.title,
    required this.nominal,
    required this.status,
    required this.onChecked,
    this.checked = false,
  }) : super(key: key);

  @override
  State<SppItem> createState() => _SppItemState();
}

class _SppItemState extends State<SppItem> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _alreadyPaid = widget.status == PaymentStatus.accept || widget.nominal == 0;
    return RoundedContainer(
      padding: const EdgeInsets.only(
        top: AppDimensions.medium,
        bottom: AppDimensions.medium,
        right: AppDimensions.medium,
        left: AppDimensions.small,
      ),
      shadow: true,
      shadowBlurRadius: 8,
      shadowSpreadRadius: 4,
      shadowOffset: const Offset(0, 4),
      shadowColor: Colors.grey.withOpacity(0.10),
      radius: 10.0,
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            checkColor: Colors.white,
            activeColor: AppColors.primary,
            value: _alreadyPaid ? true : isChecked,
            onChanged: _alreadyPaid
                ? null
                : (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                    widget.onChecked!();
                  },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                ),
                Text(
                  widget.nominal == 0 ? 'Tidak Perlu Membayar' : AppHelpers.getFormattedPrice(widget.nominal),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    color: widget.nominal == 0 ? AppColors.textGrey : AppColors.primary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.nominal != 0
                        ? ActionButton(
                            status: widget.status,
                          )
                        : const SizedBox.shrink()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final PaymentStatus? status;
  const ActionButton({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const RoundedContainer(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        height: 20.0,
        radius: 10.0,
        color: AppColors.error,
        child: Center(
          child: Text(
            'BELUM DIBAYAR',
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      switch (status) {
        case PaymentStatus.process:
        case PaymentStatus.accept:
          return const RoundedContainer(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            height: 20.0,
            radius: 10.0,
            color: AppColors.success,
            child: Center(
              child: Text(
                'SUDAH DIBAYAR',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        case PaymentStatus.reject:
          return const RoundedContainer(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            height: 20.0,
            radius: 10.0,
            color: AppColors.error,
            child: Center(
              child: Text(
                'DITOLAK',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        default:
          return const RoundedContainer(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            height: 20.0,
            radius: 10.0,
            color: AppColors.error,
            child: Center(
              child: Text(
                'BELUM DIBAYAR',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
      }
    }
  }
}
