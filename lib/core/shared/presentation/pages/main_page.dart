import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/student_payment/presentation/pages/student_payment_page.dart';
import '../../../../features/student_registration/presentation/pages/student_registration_page.dart';
import '../cubits/navbar_cubit.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'not_found_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _navbarCubit = NavbarCubit(0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _navbarCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<NavbarCubit, int>(
            builder: (context, state) {
              if (state == 0) {
                return const StudentRegistrationPage();
              } else if (state == 1) {
                return StudentPaymentPage(navbarCubit: _navbarCubit
                );
              } else if (state == 2) {
                return const ColoredBox(
                  color: Colors.yellow,
                  child: SizedBox.expand(),
                );
              } else {
                return const NotFoundPage();
              }
            },
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigation(),
      ),
    );
  }
}
