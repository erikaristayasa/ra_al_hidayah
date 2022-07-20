import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/student_payment/presentation/pages/payment_history_page.dart';

import '../../../../features/student_payment/presentation/pages/student_payment_page.dart';
import '../../../../features/student_registration/presentation/pages/student_registration_page.dart';
import '../cubits/navbar_cubit.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'not_found_page.dart';

class MainPageRouteArgument {
  final int page;

  MainPageRouteArgument({this.page = 0});
}

class MainPage extends StatefulWidget {
  final int page;
  const MainPage({Key? key, this.page = 0}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late NavbarCubit _navbarCubit;

  @override
  void initState() {
    _navbarCubit = NavbarCubit(widget.page);
    super.initState();
  }
  
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
                return StudentPaymentPage(navbarCubit: _navbarCubit);
              } else if (state == 2) {
                return const PaymentHistoryPage();
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
