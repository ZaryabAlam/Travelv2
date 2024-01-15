import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [CommonText(text: 'Booking Screen')],
      ),
    );
  }
}
