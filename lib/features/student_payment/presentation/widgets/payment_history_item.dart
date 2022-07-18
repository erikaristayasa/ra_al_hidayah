import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_button.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/statics/statics.dart';

class PaymentHistoryItem extends StatefulWidget {
  final String title;
  final int nominal;

  final PaymentStatus? status;
  const PaymentHistoryItem({Key? key, required this.title, required this.nominal, this.status}) : super(key: key);

  @override
  State<PaymentHistoryItem> createState() => _PaymentHistoryItemState();
}

class _PaymentHistoryItemState extends State<PaymentHistoryItem> {
  bool _isExpanded = false;
  Color _color = AppColors.primary;

  prepareColor() {
    if (widget.nominal == 0) {
      _color = Colors.grey;
      return;
    }
    switch (widget.status) {
      case PaymentStatus.draft:
      case PaymentStatus.process:
        _color = AppColors.process;
        break;
      case PaymentStatus.accept:
        _color = AppColors.primary;
        break;
      case PaymentStatus.reject:
        _color = AppColors.error;
        break;
      default:
        _color = AppColors.error;
        break;
    }
  }

  @override
  void initState() {
    prepareColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _alreadyPaid = widget.status == PaymentStatus.accept || widget.status == PaymentStatus.process;
    return RoundedContainer(
      radius: 10.0,
      color: AppColors.textFieldGrey,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          trailing: RoundedContainer(
            padding: const EdgeInsets.all(0.0),
            height: 27,
            width: 27,
            color: AppColors.primary.withOpacity(0.15),
            child: Center(
              child: Icon(
                _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          title: _isExpanded
              ? const SizedBox.shrink()
              : Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: _color,
                    ),
                    AppHelpers.mediumHorizontalSpacing(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.0,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(2.0)),
                  //   child:
                  // ),
                  VerticalDivider(
                    color: _color,
                    thickness: 5.0,
                  ),
                  AppHelpers.smallHorizontalSpacing(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppDimensions.large),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.0,
                                  height: 2.0,
                                ),
                              ),
                              // Text(
                              //   AppHelpers.getFormattedPrice(widget.nominal),
                              //   style: const TextStyle(
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 12.0,
                              //     color: AppColors.textGrey,
                              //     height: 2.0,
                              //   ),
                              // )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Total biaya yang masih harus dibayar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.0,
                                    height: 2.0,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                AppHelpers.getFormattedPrice(_alreadyPaid ? 0 : widget.nominal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: AppColors.textGrey,
                                  height: 2.0,
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: _color,
                            thickness: 1.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0,
                                  height: 2.0,
                                ),
                              ),
                              Text(
                                AppHelpers.getFormattedPrice(_alreadyPaid ? 0 : widget.nominal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  height: 2.0,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Jumlah yang telah dibayarkan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.0,
                                    height: 2.0,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                AppHelpers.getFormattedPrice(!_alreadyPaid ? 0 : widget.nominal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  height: 2.0,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.0,
                                  height: 2.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
                                child: StatusLabel(
                                  status: widget.status,
                                  skip: widget.nominal == 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.status == PaymentStatus.reject
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.large),
                    child: Column(
                      children: [
                        const Text(
                          'Terjadi kesalahan saat upload bukti transfer. Silahkan lakukan upload ulang.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0,
                            color: AppColors.error,
                          ),
                        ),
                        AppHelpers.mediumVerticalSpacing(),
                        RoundedButton(
                          radius: 5.0,
                          outline: true,
                          title: 'Upload Ulang',
                          titleColor: AppColors.primary,
                          outlineBodyColor: AppColors.bgGrey,
                          onTap: () {},
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class StatusLabel extends StatelessWidget {
  final bool skip;
  final PaymentStatus? status;
  const StatusLabel({Key? key, required this.status, this.skip = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (skip) {
      return const RoundedContainer(
        radius: 10.0,
        child: Text(
          'TIDAK BAYAR',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
        color: Colors.grey,
      );
    }
    if (status == null) {
      return const RoundedContainer(
        radius: 10.0,
        child: Text(
          'BELUM DIBAYAR',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.0,
            color: Colors.white,
          ),
        ),
        color: AppColors.error,
      );
    }
    switch (status!) {
      case PaymentStatus.draft:
      case PaymentStatus.process:
        return const RoundedContainer(
          radius: 10.0,
          child: Text(
            'DIPROSES',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          color: AppColors.process,
        );
      case PaymentStatus.accept:
        return const RoundedContainer(
          radius: 10.0,
          child: Text(
            'SUDAH DIBAYAR',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          color: AppColors.success,
        );

      case PaymentStatus.reject:
        return const RoundedContainer(
          radius: 10.0,
          child: Text(
            'DITOLAK',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
              color: Colors.white,
            ),
          ),
          color: AppColors.error,
        );
    }
  }
}
