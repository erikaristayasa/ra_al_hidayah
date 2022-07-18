import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/domain/entities/payment_status_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/spp_item.dart';

class PaymentSppDetailPageRouteArguments {
  final Student student;
  final int nominal;

  PaymentSppDetailPageRouteArguments({
    required this.student,
    required this.nominal,
  });
}

class PaymentSppDetailPage extends StatefulWidget {
  final Student student;
  final int nominal;
  const PaymentSppDetailPage({Key? key, required this.student, required this.nominal}) : super(key: key);

  @override
  State<PaymentSppDetailPage> createState() => _PaymentSppDetailPageState();
}

class _PaymentSppDetailPageState extends State<PaymentSppDetailPage> {
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

  selectMonth(int month) {
    if (_selectedMonths.contains(month)) {
      _selectedMonths.remove(month);
    } else {
      _selectedMonths.add(month);
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
        title: 'Pembayaran SPP',
        canBack: true,
      ),
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.medium,
                        horizontal: AppDimensions.large,
                      ),
                      separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
                      itemBuilder: (context, i) {
                        final _month = _months[i];
                        final _sppMonthExist =
                            state.paymentDetails.where((element) => element.type == PaymentType.spp && element.month == _month).length;
                        if (_sppMonthExist > 0) {
                          selectMonth(_month);
                        }
                        return SppItem(
                          title: _month.monthName,
                          nominal: widget.nominal,
                          status: _sppStatus.getAt(_month),
                          checked: _sppMonthExist > 0,
                          onChecked: () {
                            selectMonth(_month);
                          },
                        );
                      },
                      itemCount: _months.length,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.medium,
                  horizontal: AppDimensions.large,
                ),
                child: RoundedButton(
                  title: 'Tambah Ke Rincian',
                  onTap: () {
                    AppHelpers.logMe(_selectedMonths);
                    context.read<CartBloc>().add(AddSppMonths(months: _selectedMonths, nominal: widget.nominal));
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
