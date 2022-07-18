import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../widgets/payment_item_list.dart';

class PaymentDetailPageRouteArguments {
  final Student student;

  PaymentDetailPageRouteArguments({required this.student});
}

class PaymentDetailPage extends StatelessWidget {
  final Student student;
  const PaymentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Pembayaran Siswa',
        canBack: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.large),
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'KETERANGAN: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      color: AppColors.error,
                    ),
                  ),
                  TextSpan(
                    text: 'Jika anda daftar ulang, silahkan lakukan pembayaran untuk seragam dan SPP bulan pertama.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0,
                    ),
                  )
                ],
              ),
            ),
            AppHelpers.mediumVerticalSpacing(),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: '*Pembayaran untuk '),
                TextSpan(
                  text: '${student.name} ',
                  style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                ),
                const TextSpan(text: 'dari '),
                TextSpan(
                  text: student.type.text,
                  style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                )
              ], style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10.0)),
            ),
            AppHelpers.mediumVerticalSpacing(),
            PaymentItemList(student: student),
          ],
        ),
      ),
    );
  }
}
