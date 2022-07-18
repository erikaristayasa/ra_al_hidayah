import 'package:flutter/material.dart';

import '../../features/change_password/presentation/pages/change_password_page.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/otp/presentation/pages/otp_page.dart';
import '../../features/registration/presentation/pages/registration_page.dart';
import '../../features/student_payment/presentation/pages/payment_detail_page.dart';
import '../../features/student_payment/presentation/pages/payment_spp_detail_page.dart';
import '../../features/student_registration/presentation/pages/student_registration_form_page.dart';
import '../shared/presentation/pages/main_page.dart';
import '../shared/presentation/pages/not_found_page.dart';
import '../shared/presentation/pages/splash_screen_page.dart';

part 'paths.dart';

class AppRoutes {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppPaths.splashScreen:
        return jumpTo(page: const SplashScreenPage());
      case AppPaths.main:
        return jumpTo(page: const MainPage());
      case AppPaths.login:
        return jumpTo(page: const LoginPage());
      case AppPaths.register:
        return jumpTo(page: const RegistrationPage());
      case AppPaths.forgotPassword:
        return jumpTo(page: const ForgotPasswordPage());
      case AppPaths.otp:
        final args = settings.arguments as OtpPageRouteArguments;
        return jumpTo(
          page: OtpPage(token: args.token, prevPhone: args.prevPhone),
        );
      case AppPaths.changePassword:
        final args = settings.arguments as ChangePasswordPageRouteArguments;
        return jumpTo(page: ChangePasswordPage(token: args.token));
      case AppPaths.studentRegistrationForm:
        final args = settings.arguments as StudentRegistrationFormPageRouteArguments;
        return jumpTo(
          page: StudentRegistrationFormPage(
            gradeType: args.gradeType,
            period: args.period,
          ),
        );
      case AppPaths.paymentDetail:
        final args = settings.arguments as PaymentDetailPageRouteArguments;
        return jumpTo(page: PaymentDetailPage(student: args.student));
      case AppPaths.paymentSppDetail:
        final args = settings.arguments as PaymentSppDetailPageRouteArguments;
        return jumpTo(
          page: PaymentSppDetailPage(
            student: args.student,
            nominal: args.nominal,
          ),
        );
      default:
        return jumpTo(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> jumpTo({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
