import 'package:flutter/material.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';
import '../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';

class StudentItem extends StatelessWidget {
  final Student data;
  final VoidCallback onTap;
  final bool isHistory;
  const StudentItem({Key? key, required this.data, required this.onTap, this.isHistory = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(0.0),
      color: Colors.white,
      clipBerhaviour: Clip.antiAlias,
      shadow: true,
      shadowBlurRadius: 8,
      shadowSpreadRadius: 4,
      shadowOffset: const Offset(0, 4),
      shadowColor: Colors.grey.withOpacity(0.10),
      height: 80,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  YellowLabel(label: data.type.text),
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimensions.small, left: AppDimensions.medium, right: AppDimensions.medium),
                    child: Text(
                      data.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0, color: AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimensions.medium, right: AppDimensions.medium),
                    child: Text(
                      data.gender.text,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10.0, color: AppColors.textGrey),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: data.status == PaymentStatus.reject ? const ErrorLabel(error: 'Ditolak') : const SizedBox.shrink(),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.medium),
                    child: ActionButton(
                      onTap: onTap,
                      status: data.status,
                      isHistory: isHistory,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: data.rejectNote.isNotEmpty ? ErrorLabel(error: data.rejectNote) : const SizedBox.shrink(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class YellowLabel extends StatelessWidget {
  final String label;
  const YellowLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFF39A1A),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
          const Expanded(flex: 2, child: SizedBox.expand())
        ],
      ),
    );
  }
}

class ErrorLabel extends StatelessWidget {
  final String error;
  const ErrorLabel({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10.0,
        color: AppColors.error,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final PaymentStatus status;
  final bool isHistory;
  const ActionButton({Key? key, required this.onTap, required this.status, required this.isHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHistory) {
      return RoundedButton(
        radius: 5.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.remove_red_eye,
              color: Colors.white,
              size: 14.0,
            ),
            AppHelpers.smallHorizontalSpacing(),
            const Text(
              'Lihat',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0,
              ),
            ),
          ],
        ),
        onTap: onTap,
      );
    }
    ;
    switch (status) {
      case PaymentStatus.draft:
      case PaymentStatus.process:
        return RoundedButton(
          radius: 5.0,
          title: const Text(
            'Diproses',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
            ),
          ),
          color: const Color(0xFFF39A1A),
          onTap: onTap,
        );
      case PaymentStatus.accept:
        return RoundedButton(
          radius: 5.0,
          title: const Text(
            'Bayar',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
            ),
          ),
          onTap: onTap,
        );
      case PaymentStatus.reject:
        return RoundedButton(
          radius: 5.0,
          title: const Text(
            'Isi Form Ulang',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.0,
            ),
          ),
          color: AppColors.error,
          onTap: () {},
        );
    }
  }
}
