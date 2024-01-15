import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CommonText(text: 'Home Screen')],
      ),
    );
  }
}
