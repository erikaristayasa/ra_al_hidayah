import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/custom_photo_field.dart';
import '../../../../core/shared/presentation/widgets/rekening_info.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../widgets/bottom_sheet_cancel_payment.dart';
import '../widgets/bottom_sheet_payment_detail.dart';

class PaymentMethodPageRouteArguments {
  final PaymentBody? result;
  final int paymentId;
  final Student student;

  PaymentMethodPageRouteArguments({
    required this.result,
    required this.paymentId,
    required this.student,
  });
}

class PaymentMethodPage extends StatefulWidget {
  final PaymentBody? result;
  final int paymentId;
  final Student student;
  const PaymentMethodPage({
    Key? key,
    required this.result,
    required this.paymentId,
    required this.student,
  }) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  backConfirmation() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const BottomSheetCancelPayment(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backConfirmation();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Detail Pembayaran',
          canBack: true,
          customBackAction: backConfirmation,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.large,
              vertical: AppDimensions.medium,
            ),
            children: [
              RoundedContainer(
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
                        'Jika membayar secara cash/tunai, maka langsung konfirmasi dengan sekolah.',
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
              AppHelpers.mediumVerticalSpacing(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Informasi Pembayaran',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                    ),
                  ),
                  AppHelpers.smallVerticalSpacing(),
                  const Text(
                    'Silahkan lihat informasi pembayaran yang tersedia.',
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
              RoundedContainer(
                color: AppColors.primary,
                radius: 10.0,
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.medium),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                    AppHelpers.mediumHorizontalSpacing(),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Harus membayar '),
                            TextSpan(
                              text: AppHelpers.getFormattedPrice(300000),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => const BottomSheetPaymentDetail(),
                        );
                      },
                      child: const Text(
                        'Lihat Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              AppHelpers.mediumVerticalSpacing(),
              const Text(
                'Informasi Pembayaran Transfer',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.0,
                  color: AppColors.primary,
                ),
              ),
              AppHelpers.mediumVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [Expanded(flex: 2, child: RekeningInfo()), Expanded(flex: 3, child: SizedBox.shrink())],
              ),
              AppHelpers.mediumVerticalSpacing(),
              const Text(
                '*Jangka waktu pembayaran hanya satu minggu  saja.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.0,
                  color: AppColors.error,
                ),
              ),
              AppHelpers.mediumVerticalSpacing(),
              const Text(
                'Upload Bukti Transfer',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10.0,
                  color: AppColors.primary,
                ),
              ),
              AppHelpers.mediumVerticalSpacing(),
              CustomPhotoField(
                bottomDescription: '',
                onPicked: (file) {},
                showDeleteButton: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
                child: RoundedButton(
                  title: 'Kirim',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
