import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/custom_app_bar.dart';
import 'package:ra_al_hidayah/features/student_payment/presentation/widgets/payment_history_item_list.dart';

import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class PaymentHistoryDetailPageRouteArguments {
  final Student student;

  PaymentHistoryDetailPageRouteArguments({required this.student});
}

class PaymentHistoryDetailPage extends StatelessWidget {
  final Student student;
  const PaymentHistoryDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Detail Riwayat Pembayaran',
        canBack: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.medium,
            horizontal: AppDimensions.large,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Jadwal Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.0,
                  ),
                ),
                AppHelpers.smallVerticalSpacing(),
                const Text(
                  'Lihat update jadwal pembayaran bulanan di bawah ini dan klik tanggal tertentu untuk informasi lebih lanjut.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                    color: AppColors.textGrey,
                    height: 1.5,
                  ),
                ),
                AppHelpers.mediumVerticalSpacing(),
                PaymentHistoryItemList(student: student),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
