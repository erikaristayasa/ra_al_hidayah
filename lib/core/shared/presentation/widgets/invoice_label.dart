import 'package:flutter/cupertino.dart';
import 'rounded_container.dart';
import '../../../utilities/utilities.dart';

import '../../../statics/statics.dart';

class InvoiceLabel extends StatelessWidget {
  final int nominal;
  final String name;
  final String address;
  final DateTime date;
  const InvoiceLabel({
    Key? key,
    required this.nominal,
    required this.name,
    required this.address,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppDimensions.medium),
      color: const Color(0xFFE8FFFC),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'INVOICE UNTUK',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  address,
                  style: const TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: AppColors.textGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HARUS DIBAYAR',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  AppHelpers.getFormattedPrice(nominal),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      '●',
                      style: TextStyle(color: Color(0xFFF39A1A)),
                    ),
                    AppHelpers.smallHorizontalSpacing(),
                    Text(
                      date.toText(format: 'dd MMMM yyyy'),
                      style: const TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: AppColors.textGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
