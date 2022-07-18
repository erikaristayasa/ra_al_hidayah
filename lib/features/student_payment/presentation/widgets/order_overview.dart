import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ra_al_hidayah/core/shared/domain/entities/student_entity.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/shared/presentation/widgets/invoice_label.dart';
import '../bloc/cart/cart_bloc.dart';

class OrderOverview extends StatelessWidget {
  final Student student;
  const OrderOverview({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(
      //   vertical: AppDimensions.medium,
      //   horizontal: AppDimensions.large,
      // ),
      // padding: const EdgeInsets.all(AppDimensions.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: AppColors.textFieldGrey,
          width: 1.0,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.large,
              vertical: AppDimensions.medium,
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 47,
                  width: 47,
                ),
                AppHelpers.mediumHorizontalSpacing(),
                const Text(
                  'Rincian Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return InvoiceLabel(
                  nominal: state.total,
                  name: student.name,
                  address: student.address,
                  date: DateTime.now(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
