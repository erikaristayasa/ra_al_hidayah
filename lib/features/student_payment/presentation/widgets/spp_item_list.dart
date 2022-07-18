import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_button.dart';

import '../../../../core/shared/domain/entities/payment_status_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import 'spp_item.dart';

class SppItemList extends StatefulWidget {
  final Student student;
  final int nominal;
  const SppItemList({Key? key, required this.student, required this.nominal}) : super(key: key);

  @override
  State<SppItemList> createState() => _SppItemListState();
}

class _SppItemListState extends State<SppItemList> {
  late SPP _sppStatus;
  List<int> _months = [];
  List<int> _selectedMonths = [];

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
    return ListView.separated(
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.medium,
        horizontal: AppDimensions.large,
      ),
      separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
      itemBuilder: (context, i) {
        final _month = _months[i];
        return SppItem(
          title: _month.monthName,
          nominal: widget.nominal,
          status: _sppStatus.getAt(_month),
          onChecked: () {},
        );
      },
      itemCount: _months.length,
    );
  }
}
