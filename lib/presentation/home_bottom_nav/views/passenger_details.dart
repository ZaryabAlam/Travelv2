import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/ticket_view.dart';

class PassengerDetailsScreen extends StatefulWidget {
  const PassengerDetailsScreen({super.key});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Passenger Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      text: 'Passenger',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: titleController,
                      requiredLabel: 'Title',
                      hint: 'Mr'),
                  0.03.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Custom_textfield_required(
                              controller: firstNameController,
                              requiredLabel: 'First Name',
                              hint: 'Enter First Name')),
                      Expanded(
                          child: Custom_textfield_required(
                              controller: lastNameController,
                              requiredLabel: 'Last Name',
                              hint: 'Enter Last Name')),
                    ],
                  ),
                  0.03.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Custom_textfield_required(
                              controller: monthController,
                              requiredLabel: 'Date of Birth',
                              hint: 'Month')),
                      Expanded(
                          child: CustomTextField(
                              textEditingController: dayController,
                              hintText: 'Day')),
                      Expanded(
                          child: CustomTextField(
                              textEditingController: yearController,
                              hintText: 'Year')),
                    ],
                  ),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: nationalityController,
                      requiredLabel: 'Nationality',
                      hint: 'Enter Nationality Here'),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: passportController,
                      requiredLabel: 'Passport Number',
                      hint: 'Enter Passport Here'),
                  0.03.ph,
                  CommonText(
                      text: 'Contact Information',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: nationalityController,
                      requiredLabel: 'Nationality',
                      hint: 'Enter Nationality Here'),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: passportController,
                      requiredLabel: 'Passport Number',
                      hint: 'Enter Passport Here'),
                  0.04.ph,
                  CommonText(
                      text: 'Flight Summary',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                ],
              ),
            ),
            FlightSummaryWidget(),
            0.1.ph,
            0.03.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineButton(width: 150, text: "Back", onPress: () {}),
                CustomButton(width: 150, text: "Confirm", onPress: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
