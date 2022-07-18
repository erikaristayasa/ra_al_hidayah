import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/routes/routes.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/student_entity.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/features/student_payment/presentation/pages/payment_history_spp_detail_page.dart';
import 'package:ra_al_hidayah/features/student_payment/presentation/widgets/payment_history_item.dart';

import '../../../../core/shared/domain/entities/payment_status_entity.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class PaymentHistoryItemList extends StatefulWidget {
  final Student student;
  const PaymentHistoryItemList({Key? key, required this.student}) : super(key: key);

  @override
  State<PaymentHistoryItemList> createState() => _PaymentHistoryItemListState();
}

class _PaymentHistoryItemListState extends State<PaymentHistoryItemList> {
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
        PaymentHistoryItem(
          title: PaymentType.activity.title,
          nominal: _activityCost,
          status: _paymentsStatus.activity,
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentHistoryItem(
          title: PaymentType.stationary.title,
          nominal: _stationaryCost,
          status: _paymentsStatus.stationary,
        ),
        AppHelpers.mediumVerticalSpacing(),
        RoundedContainer(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: AppDimensions.medium,
          ),
          radius: 10.0,
          color: AppColors.textFieldGrey,
          child: Row(
            children: [
              const Icon(
                Icons.circle,
                color: AppColors.primary,
              ),
              AppHelpers.mediumHorizontalSpacing(),
              Expanded(
                child: Text(
                  PaymentType.spp.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 9.0,
                    color: Colors.black,
                  ),
                ),
              ),
              RoundedButton(
                radius: 5.0,
                width: 100,
                height: 30,
                title: const Text(
                  'Lihat Detail',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPaths.paymentHistorySppDetail,
                    arguments: PaymentHistorySppDetailPageRouteArguments(
                      student: widget.student,
                      nominal: _sppCost,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentHistoryItem(
          title: PaymentType.uniform.title,
          nominal: _uniformCost,
          status: _paymentsStatus.uniform,
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentHistoryItem(
          title: PaymentType.buildingMoney.title,
          nominal: _buildingMoneyCost,
          status: _paymentsStatus.buildingMoney,
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentHistoryItem(
          title: PaymentType.hood.title,
          nominal: _hoodCost,
          status: _paymentsStatus.hood,
        ),
        AppHelpers.mediumVerticalSpacing(),
      ],
    );
  }
}
