import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/presentation/home_bottom_nav/bnb/bottom_nav_view.dart';
// import 'package:travel_app/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel v2 App',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BottomNavScreen()
        // SplashScreen(),
        );
  }
}
