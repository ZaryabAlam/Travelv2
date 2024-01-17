import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';

class SortScreen extends StatefulWidget {
  const SortScreen({super.key});

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(title: "Sort by"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Buildbutton(buttonText: "Recommended"),
              Buildbutton(buttonText: "Price (Low to High)"),
              Buildbutton(buttonText: "Price (High to Low)"),
              Buildbutton(buttonText: "Duration (Shortest)"),
              Buildbutton(buttonText: "Duration (Longest)"),
              Buildbutton(buttonText: "Departure (Earliest)"),
              Buildbutton(buttonText: "Departure (Latest)"),
              Buildbutton(buttonText: "Arrival (Earliest)"),
              Buildbutton(buttonText: "Arrival (Latest)"),
              0.03.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomOutlineButton(
                      width: 150, text: "Clear", onPress: () {}),
                  CustomButton(width: 150, text: "Apply", onPress: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Buildbutton extends StatelessWidget {
  String buttonText;
  Buildbutton({
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: () {},
      title: CommonText(
        text: buttonText,
        weight: FontWeight.w400,
        fontSize: 16,
      ),
      subtitle: const Divider(),
    );
  }
}
