import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CommonText(text: 'Check In Screen')],
      ),
    );
  }
}
