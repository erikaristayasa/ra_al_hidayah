import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubits/navbar_cubit.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'not_found_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<NavbarCubit, int>(
            builder: (context, state) {
              if (state == 0) {
                return const ColoredBox(
                  color: Colors.blue,
                  child: SizedBox.expand(),
                );
              } else if (state == 1) {
                return const ColoredBox(
                  color: Colors.red,
                  child: SizedBox.expand(),
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
