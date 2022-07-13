import 'package:flutter/material.dart';
import '../../../../core/shared/presentation/widgets/page_description.dart';
import '../../../../core/statics/statics.dart';

import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../widgets/student_registration_page_indicator.dart';

class StudentRegistrationFormPage extends StatelessWidget {
  const StudentRegistrationFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Form Pendaftaran Siswa',
        canBack: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
          children: const [
            PageDescription(title: 'Data Diri Siswa', description: 'Silahkan isi data diri yang sesuai.'),
            StudentRegistrationPageIndicator(currentPage: 0)
          ],
        ),
      ),
    );
  }
}
