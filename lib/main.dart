import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/presentation/auth/login_screen.dart';
import 'package:travel_app/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Travel v2 App',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColorPrimary),
        useMaterial3: true,
        primarySwatch: Colors.blue,
        //  appBarTheme: AppBarTheme(
        //     backgroundColor: AppColors.appColorPrimary,
        //     iconTheme: IconThemeData(color: white),
        //     foregroundColor: white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      // home: SplashScreen(),
      home: LoginScreen(),
    );
  }
}
