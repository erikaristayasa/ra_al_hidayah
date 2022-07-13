import 'package:flutter/material.dart';

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
        
      case AppPaths.forgotPassword:
        
      case AppPaths.otp:
        
      case AppPaths.changePassword:
        
      case AppPaths.verificationSuccess:
        
      case AppPaths.register:
      
      default:
        return jumpTo(page: const NotFoundPage());
    }
  }

  static MaterialPageRoute<dynamic> jumpTo({required Widget page}) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
