import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/core/statics/statics.dart';

import '../cubit/student_registration_page_cubit.dart';

class StudentRegistrationPageIndicator extends StatelessWidget {
  final int currentPage;
  const StudentRegistrationPageIndicator({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.read<StudentRegistrationPageCubit>().move(0);
          },
          child: RoundedContainer(
            height: 41,
            width: 41,
            radius: 41 / 2,
            color: currentPage == 0 ? AppColors.primary : AppColors.indicatorGrey,
            child: const Center(
              child: Text(
                '1',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          AppAssets.iconFormIndicatorArrow,
          color: currentPage == 0 ? AppColors.primary : AppColors.indicatorGrey,
        ),
        Expanded(
            child: Divider(
          thickness: 1.5,
          color: currentPage == 0 ? AppColors.primary : AppColors.indicatorGrey,
        )),
        InkWell(
          onTap: () {
            context.read<StudentRegistrationPageCubit>().move(1);
          },
          child: RoundedContainer(
            height: 41,
            width: 41,
            radius: 41 / 2,
            color: currentPage == 1 ? AppColors.primary : AppColors.indicatorGrey,
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          AppAssets.iconFormIndicatorArrow,
          color: currentPage == 1 ? AppColors.primary : AppColors.indicatorGrey,
        ),
        Expanded(
            child: Divider(
          thickness: 1.5,
          color: currentPage == 1 ? AppColors.primary : AppColors.indicatorGrey,
        )),
        InkWell(
          onTap: () {
            context.read<StudentRegistrationPageCubit>().move(2);
          },
          child: RoundedContainer(
            height: 41,
            width: 41,
            radius: 41 / 2,
            color: currentPage == 2 ? AppColors.primary : AppColors.indicatorGrey,
            child: const Center(
              child: Text(
                '3',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
