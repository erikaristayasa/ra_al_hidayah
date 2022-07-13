import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';
import '../cubits/navbar_cubit.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.075),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: BlocBuilder<NavbarCubit, int>(
        builder: (context, state) {
          final _navbar = context.read<NavbarCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.small,
              horizontal: AppDimensions.large,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavbarButton(
                  icon: AppAssets.navbarRegistration,
                  title: 'Pendaftaran',
                  isSelected: state == 0,
                  onSelected: () => _navbar.change(0),
                ),
                NavbarButton(
                  icon: AppAssets.navbarPayment,
                  title: 'Pembayaran',
                  isSelected: state == 1,
                  onSelected: () => _navbar.change(1),
                ),
                NavbarButton(
                  icon: AppAssets.navbarHistory,
                  title: 'Riwayat',
                  isSelected: state == 2,
                  onSelected: () => _navbar.change(2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onSelected;

  const NavbarButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
            width: 24.0,
            height: 24.0,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              fontSize: 12.0,
              overflow: TextOverflow.ellipsis,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
