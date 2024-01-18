import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/ticket_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/booking_details.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: 'Card Details', weight: FontWeight.w600, fontSize: 18.0),
                  0.03.ph,
                  Custom_textfield_required(controller: cardController, requiredLabel: 'Card Number', hint: 'Enter Card Number here'),
                  0.03.ph,
                  Custom_textfield_required(controller: fullNameController, requiredLabel: 'Full Name', hint: 'Enter Full Name (Same as Card)'),
                  0.03.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Custom_textfield_required(controller: monthController, requiredLabel: 'Date of Birth', hint: 'Month')),
                      Expanded(child: CustomTextField(textEditingController: yearController, hintText: 'Year')),
                    ],
                  ),
                  0.03.ph,
                ],
              ),
            ),
            // FlightSummaryWidget(),
            0.01.ph,

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(child: Icon(Icons.info)),
              // 0.02.pw,
              Expanded(
                  flex: 8,
                  child: CommonText(
                    text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                    textAlign: TextAlign.justify,
                  ))
            ]),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineButton(
                    width: 150,
                    text: "Back",
                    onPress: () {
                      Get.back();
                    }),
                CustomButton(
                    width: 150,
                    text: "Confirm",
                    onPress: () {
                      Get.to(() => BookingDetailsScreen());
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
