import 'package:flutter/material.dart';
import '../widgets/payment_history_item.dart';

import '../../../../core/shared/domain/entities/payment_status_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class PaymentHistorySppDetailPageRouteArguments {
  final Student student;
  final int nominal;

  PaymentHistorySppDetailPageRouteArguments({required this.student, required this.nominal});
}

class PaymentHistorySppDetailPage extends StatefulWidget {
  final Student student;
  final int nominal;
  const PaymentHistorySppDetailPage({Key? key, required this.student, required this.nominal}) : super(key: key);

  @override
  State<PaymentHistorySppDetailPage> createState() => _PaymentHistorySppDetailPageState();
}

class _PaymentHistorySppDetailPageState extends State<PaymentHistorySppDetailPage> {
  late SPP _sppStatus;
  List<int> _months = [];

  preparePaymentsStatus() {
    _sppStatus = widget.student.paymentsStatus.spp;
  }

  prepareMonthSpp() {
    final startMonth = widget.student.registrationPeriod?.startDate.month ?? 1;
    int i = startMonth;
    for (var j = 0; j < 6; j++) {
      _months.add(i);
      i++;
    }
  }

  @override
  void initState() {
    prepareMonthSpp();
    preparePaymentsStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Riwayat Pembayaran SPP',
        canBack: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.medium,
            horizontal: AppDimensions.large,
          ),
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _months.length,
              itemBuilder: (context, i) {
                final _month = _months[i];
                return PaymentHistoryItem(
                  title: PaymentType.spp.title + ' (${_month.monthName})',
                  nominal: widget.nominal,
                  status: _sppStatus.getAt(_month),
                );
              },
              separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
            )
          ],
        ),
      ),
    );
  }
}
