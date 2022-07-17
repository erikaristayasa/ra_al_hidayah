import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/page_description.dart';
import '../../../../core/statics/statics.dart';
import '../cubit/student_registration_page_cubit.dart';
import '../widgets/student_registration_page_indicator.dart';
import 'form/first_form.dart';
import 'form/second_form.dart';
import 'form/third_form.dart';

class StudentRegistrationFormPageRouteArguments {
  final GradeType gradeType;

  StudentRegistrationFormPageRouteArguments({required this.gradeType});
}

class StudentRegistrationFormPage extends StatefulWidget {
  final GradeType gradeType;
  const StudentRegistrationFormPage({Key? key, required this.gradeType}) : super(key: key);

  @override
  State<StudentRegistrationFormPage> createState() => _StudentRegistrationFormPageState();
}

class _StudentRegistrationFormPageState extends State<StudentRegistrationFormPage> {
  final _pageCubit = StudentRegistrationPageCubit();
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _pageCubit,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Form Pendaftaran Siswa',
          canBack: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
            child: Column(
              children: [
                PageDescription(title: 'Data Diri Siswa ${widget.gradeType.text}', description: 'Silahkan isi data diri yang sesuai.'),
                BlocConsumer<StudentRegistrationPageCubit, int>(
                  listener: (context, state) =>
                      _pageController.animateToPage(state, duration: const Duration(microseconds: 800), curve: Curves.easeIn),
                  builder: (context, state) {
                    return StudentRegistrationPageIndicator(currentPage: state);
                  },
                ),
                AppHelpers.smallVerticalSpacing(),
                Expanded(
                  child: PageView(
                    onPageChanged: (page) {
                      _pageCubit.move(page);
                    },
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FirstForm(
                        isPlaygroup: widget.gradeType == GradeType.playgroup,
                      ),
                      const SecondForm(),
                      const ThirdForm(),
                    ],
                  ),
                ),
                AppHelpers.smallVerticalSpacing(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
