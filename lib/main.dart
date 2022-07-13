import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'core/statics/statics.dart';
import 'core/utilities/utilities.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  locatorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ra Al Hidayah',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          context.textTheme(),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      onGenerateRoute: AppRoutes.generate,
      initialRoute: AppPaths.splashScreen,
    );
  }
}
