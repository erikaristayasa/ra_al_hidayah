import 'package:flutter/material.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class PaymentDetailDialog extends StatelessWidget {
  const PaymentDetailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        child: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
          },
          children: [
            TableRow(
              children: [
                ColoredBox(
                  color: AppColors.primary.withOpacity(0.2),
                  child: const SizedBox(
                    height: 35,
                  ),
                ),
                Container(
                  color: AppColors.primary.withOpacity(0.2),
                  padding: const EdgeInsets.all(AppDimensions.small),
                  height: 35,
                  child: const Center(
                    child: Text(
                      'Laki-laki',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, color: AppColors.primary),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.primary.withOpacity(0.2),
                  padding: const EdgeInsets.all(AppDimensions.small),
                  height: 35,
                  child: const Center(
                    child: Text(
                      'Perempuan',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, color: AppColors.primary),
                    ),
                  ),
                )
              ],
            ),
            TableRow(children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(AppDimensions.small),
                child: const Text(
                  'Formulir',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(AppDimensions.small),
                child: Text(
                  AppHelpers.getFormattedPrice(100000),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(AppDimensions.small),
                child: Text(
                  AppHelpers.getFormattedPrice(100000),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
