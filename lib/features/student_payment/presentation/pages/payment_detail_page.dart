import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/domain/entities/payment_body_entity.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/create/create_payment_bloc.dart';
import '../widgets/order_overview.dart';
import '../widgets/payment_item_list.dart';
import 'payment_method_page.dart';

class PaymentDetailPageRouteArguments {
  final Student student;

  PaymentDetailPageRouteArguments({required this.student});
}

class PaymentDetailPage extends StatefulWidget {
  final Student student;
  const PaymentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  final _cartBloc = CartBloc();
  final _createBloc = locator<CreatePaymentBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _cartBloc,
        ),
        BlocProvider(
          create: (context) => _createBloc,
        ),
      ],
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            title: 'Pembayaran Siswa',
            canBack: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.large),
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'KETERANGAN: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0,
                          color: AppColors.error,
                        ),
                      ),
                      TextSpan(
                        text: 'Jika anda daftar ulang, silahkan lakukan pembayaran untuk seragam dan SPP bulan pertama.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      )
                    ],
                  ),
                ),
                AppHelpers.mediumVerticalSpacing(),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: '*Pembayaran untuk '),
                    TextSpan(
                      text: '${widget.student.name} ',
                      style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                    ),
                    const TextSpan(text: 'dari '),
                    TextSpan(
                      text: widget.student.type.text,
                      style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                    )
                  ], style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10.0)),
                ),
                AppHelpers.mediumVerticalSpacing(),
                PaymentItemList(
                  student: widget.student,
                  cartBloc: _cartBloc,
                ),
                OrderOverview(
                  student: widget.student,
                ),
                AppHelpers.mediumVerticalSpacing(),
                BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    AppHelpers.logMe(state.paymentDetails);
                  },
                  builder: (context, state) {
                    final _paymentBody = PaymentBody(studentId: widget.student.id, total: state.total, paymentDetails: state.paymentDetails);
                    return BlocConsumer<CreatePaymentBloc, CreatePaymentState>(
                      listener: (context, state) {
                        if (state is CreatePaymentLoading) {
                          context.loaderOverlay.show();
                        } else {
                          context.loaderOverlay.hide();
                          if (state is CreatePaymentFailure) {
                            Fluttertoast.showToast(msg: AppHelpers.getErrorMessage(state.failure));
                          } else if (state is CreatePaymentCreated) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppPaths.paymentMethod,
                              arguments: PaymentMethodPageRouteArguments(
                                result: state.result,
                                paymentId: state.id,
                                student: widget.student,
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return RoundedButton(
                          title: 'Lanjutkan Pembayaran',
                          onTap: () {
                            context.read<CreatePaymentBloc>().add(Submit(body: _paymentBody));
                          },
                        );
                      },
                    );
                  },
                ),
                AppHelpers.mediumVerticalSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
