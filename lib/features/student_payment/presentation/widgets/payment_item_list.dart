import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/payment_status_entity.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';
import 'package:ra_al_hidayah/features/student_payment/presentation/widgets/payment_item.dart';

import '../../../../core/shared/domain/entities/student_entity.dart';

class PaymentItemList extends StatefulWidget {
  final Student student;
  const PaymentItemList({Key? key, required this.student}) : super(key: key);

  @override
  State<PaymentItemList> createState() => _PaymentItemListState();
}

class _PaymentItemListState extends State<PaymentItemList> {
  int _activityCost = 0;
  int _stationaryCost = 0;
  int _uniformCost = 0;
  int _sppCost = 0;
  int _hoodCost = 0;
  int _buildingMoneyCost = 0;
  int _totalCost = 0;

  late PaymentsStatus _paymentsStatus;

  prepareCosts() {
    final _gender = widget.student.gender;
    try {
      final _costBreakdown =
          widget.student.registrationPeriod?.reRegistration.costBreakdowns.where((value) => value.type == widget.student.type).last;
      if (_gender == Gender.male) {
        _activityCost = _costBreakdown?.maleActivity ?? 0;
        _stationaryCost = _costBreakdown?.maleStationary ?? 0;
        _uniformCost = _costBreakdown?.maleUniform ?? 0;
        _sppCost = _costBreakdown?.maleSpp ?? 0;
        _hoodCost = _costBreakdown?.maleHood ?? 0;
        _buildingMoneyCost = _costBreakdown?.maleBuildingMoney ?? 0;
        _totalCost = _costBreakdown?.maleTotalCost ?? 0;
      } else {
        _activityCost = _costBreakdown?.femaleActivity ?? 0;
        _stationaryCost = _costBreakdown?.femaleStationary ?? 0;
        _uniformCost = _costBreakdown?.femaleUniform ?? 0;
        _sppCost = _costBreakdown?.femaleSpp ?? 0;
        _hoodCost = _costBreakdown?.femaleHood ?? 0;
        _buildingMoneyCost = _costBreakdown?.femaleBuildingMoney ?? 0;
        _totalCost = _costBreakdown?.femaleTotalCost ?? 0;
      }
    } catch (e) {
      AppHelpers.logMe(e.toString());
    }
  }

  preparePaymentsStatus() {
    _paymentsStatus = widget.student.paymentsStatus;
  }

  @override
  void initState() {
    prepareCosts();
    preparePaymentsStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentItem(
          title: 'Pembayaran Kegiatan',
          nominal: _activityCost,
          onTap: null,
          status: _paymentsStatus.activity,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Alat Tulis & Buku Paket',
          nominal: _stationaryCost,
          onTap: null,
          status: _paymentsStatus.stationary,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran SPP/Bulan',
          nominal: _sppCost,
          onTap: () {},
          status: null,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Seragam 5 Stel',
          nominal: _uniformCost,
          onTap: () {},
          status: _paymentsStatus.uniform,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Uang Bangunan',
          nominal: _buildingMoneyCost,
          onTap: () {},
          status: _paymentsStatus.buildingMoney,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Kerudung',
          nominal: _hoodCost,
          onTap: () {},
          status: _paymentsStatus.hood,
          onChecked: () {},
        ),
        AppHelpers.mediumVerticalSpacing(),
      ],
    );
  }
}
