import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/payment_detail_entity.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/dash_line.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/statics/statics.dart';

class BottomSheetPaymentDetail extends StatelessWidget {
  final PaymentBody? result;
  final Student student;
  const BottomSheetPaymentDetail({Key? key, required this.result, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.medium),
          topRight: Radius.circular(AppDimensions.medium),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  AppAssets.iconClose,
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      AppHelpers.getFormattedPrice(result?.total ?? 0),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                    AppHelpers.mediumVerticalSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Detail Pembayaran',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: AppColors.textGrey),
                            ),
                            Text(
                              'Jumlah',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: AppColors.textGrey),
                            ),
                          ],
                        ),
                        AppHelpers.smallVerticalSpacing(),
                        LayoutBuilder(
                          builder: (context, state) {
                            final List<Widget> _children = [];
                            final _data = result!.paymentDetails;

                            for (var item in _data) {
                              final _row = Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.type.title + (item.type == PaymentType.spp ? " (${item.month!.monthName})" : ''),
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0, height: 1.5),
                                    ),
                                    Text(
                                      AppHelpers.getFormattedPrice(item.nominal),
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0),
                                    )
                                  ],
                                ),
                              );
                              _children.add(_row);
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: _children,
                            );
                          },
                        ),
                        AppHelpers.mediumVerticalSpacing(),
                        const DashLine(),
                        AppHelpers.mediumVerticalSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: AppColors.textGrey),
                                ),
                                AppHelpers.smallVerticalSpacing(),
                                Text(
                                  AppHelpers.getFormattedPrice(result?.total ?? 0),
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0, height: 1.5),
                                )
                              ],
                            )
                          ],
                        ),
                        AppHelpers.mediumVerticalSpacing(),
                        const DashLine(),
                        AppHelpers.mediumVerticalSpacing(),
                        const Text(
                          'Detail Pelanggan',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0, color: AppColors.textGrey),
                        ),
                        AppHelpers.smallVerticalSpacing(),
                        Text(
                          student.name,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10.0, height: 1.5),
                        ),
                        AppHelpers.mediumVerticalSpacing(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
