import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

class PaymentItem extends StatefulWidget {
  final String title;
  final int nominal;
  final VoidCallback? onTap;
  final VoidCallback? onChecked;
  final PaymentStatus? status;
  const PaymentItem({
    Key? key,
    required this.title,
    required this.nominal,
    required this.onTap,
    required this.status,
    required this.onChecked,
  }) : super(key: key);

  @override
  State<PaymentItem> createState() => _PaymentItemState();
}

class _PaymentItemState extends State<PaymentItem> {
  bool isChecked = false;
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
                            onTap: widget.onTap,
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
  final VoidCallback? onTap;
  const ActionButton({Key? key, required this.status, this.onTap}) : super(key: key);

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
