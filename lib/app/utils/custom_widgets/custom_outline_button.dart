import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class CustomOutlineButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final Function() onPress;
  CustomOutlineButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 250.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Add black outline
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(2.0),
          onTap: onPress,
          child: Center(
            child: CommonText(
              text: text,
              color: Colors.black, // Change text color as needed
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
