import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:travel_app/app/configs/app_colors.dart";
import "package:travel_app/presentation/splash_screen/onboard_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.to(() => OnBoardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorSplashBG,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 120,
                width: 120,
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle, color: Colors.white),
                child: Image(image: AssetImage("assets/icons/logo.png"), fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
