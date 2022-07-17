import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ra_al_hidayah/features/student_registration/presentation/pages/student_registration_form_page.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class StudentRegistrationWarningDIalog extends StatelessWidget {
  final GradeType gradeType;
  const StudentRegistrationWarningDIalog({Key? key, required this.gradeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  AppAssets.iconClose,
                ),
              ),
            ),
            SvgPicture.asset(AppAssets.iconWarning),
            AppHelpers.mediumVerticalSpacing(),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Jika Anda ingin melanjutkan mengisi form pendaftaran yang sebelumnya, masuk ke menu'),
                  TextSpan(text: ' riwayat ', style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: 'di pilihan draft pendaftaran untuk melanjutkan.'),
                ],
              ),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
            AppHelpers.mediumVerticalSpacing(),
            Text(
              'A T A U',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: AppColors.textGrey.lighten(),
              ),
            ),
            AppHelpers.mediumVerticalSpacing(),
            const Text(
              'Jika ingin membuat data baru, klik button dibawah.',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
            AppHelpers.mediumVerticalSpacing(),
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(
                  context,
                  AppPaths.studentRegistrationForm,
                  arguments: StudentRegistrationFormPageRouteArguments(gradeType: gradeType),
                );
              },
              child: const Text(
                'ISI DATA BARU SISWA',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: AppColors.primary,
                ),
              ),
            ),
            AppHelpers.mediumVerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
