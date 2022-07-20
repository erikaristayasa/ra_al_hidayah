import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/domain/entities/payment_detail_entity.dart';
import '../../../../core/shared/domain/entities/payment_status_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/cart/cart_bloc.dart';
import '../pages/payment_spp_detail_page.dart';
import 'payment_item.dart';

class PaymentItemList extends StatefulWidget {
  final Student student;
  final CartBloc cartBloc;
  const PaymentItemList({Key? key, required this.student, required this.cartBloc}) : super(key: key);

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
          status: _paymentsStatus.activity?.status,
          onChecked: () {
            final _item = PaymentDetail(type: PaymentType.activity, nominal: _activityCost);
            widget.cartBloc.add(InsertItem(data: _item));
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Alat Tulis & Buku Paket',
          nominal: _stationaryCost,
          onTap: null,
          status: _paymentsStatus.stationary?.status,
          onChecked: () {
            final _item = PaymentDetail(type: PaymentType.stationary, nominal: _stationaryCost);
            widget.cartBloc.add(InsertItem(data: _item));
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final _sppChoosen = state.paymentDetails.where((element) => element.type == PaymentType.spp).length;
            AppHelpers.logMe('_sppChoosen: $_sppChoosen');
            return PaymentItem(
              checked: _sppChoosen > 0,
              title: 'Pembayaran SPP/Bulan',
              nominal: _sppCost,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: widget.cartBloc,
                      child: PaymentSppDetailPage(student: widget.student, nominal: _sppCost),
                    ),
                  ),
                );
              },
              status: null,
              onChecked: null,
            );
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Seragam 5 Stel',
          nominal: _uniformCost,
          onTap: null,
          status: _paymentsStatus.uniform?.status,
          onChecked: () {
            final _item = PaymentDetail(type: PaymentType.uniform, nominal: _uniformCost);
            widget.cartBloc.add(InsertItem(data: _item));
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Uang Bangunan',
          nominal: _buildingMoneyCost,
          onTap: null,
          status: _paymentsStatus.buildingMoney?.status,
          onChecked: () {
            final _item = PaymentDetail(type: PaymentType.buildingMoney, nominal: _buildingMoneyCost);
            widget.cartBloc.add(InsertItem(data: _item));
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
        PaymentItem(
          title: 'Pembayaran Kerudung',
          nominal: _hoodCost,
          onTap: null,
          status: _paymentsStatus.hood?.status,
          onChecked: () {
            final _item = PaymentDetail(type: PaymentType.hood, nominal: _hoodCost);
            widget.cartBloc.add(InsertItem(data: _item));
          },
        ),
        AppHelpers.mediumVerticalSpacing(),
      ],
    );
  }
}
