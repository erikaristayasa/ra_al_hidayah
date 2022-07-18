import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.large,
                  vertical: AppDimensions.medium,
                ),
                child: RoundedContainer(
                  color: const Color(0xFFFFF7EB),
                  padding: const EdgeInsets.all(AppDimensions.medium),
                  radius: 10.0,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconWarning,
                        color: const Color(0xFFF39A1A),
                        width: 17.5,
                        height: 17.5,
                      ),
                      AppHelpers.smallHorizontalSpacing(),
                      const Expanded(
                        child: Text(
                          'Khusus pembayaran SPP dapat dirapel untuk beberapa bulan.',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                            color: Color(0xFFF39A1A),
                            height: 2,
                          ),
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                child: Column(
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
                      'Lihat update jadwal pembayaran bulanan di bawah ini dan pilih bulan untuk proses membayar.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                        color: AppColors.textGrey,
                        height: 1.5,
                      ),
                    ),
                    AppHelpers.mediumVerticalSpacing(),
                  ],
                ),
              ),
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
