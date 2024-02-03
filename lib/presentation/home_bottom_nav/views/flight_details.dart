// ignore_for_file: unnecessary_question_mark

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/controller/flight_fare_rule_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/passenger_details.dart';

// ignore: must_be_immutable
class FlightDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  FlightDetailsScreen(
      {super.key, required this.searchID, required this.flightID});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  final FlightFareRuleController flightFareRuleController =
      Get.put(FlightFareRuleController());

  @override
  void initState() {
    super.initState();
    flightFareRuleController.fetchFareRule(widget.searchID, widget.flightID);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Flight Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // ---------------------------
            // Text(widget.flightID.toString()),
            // Text(widget.searchID.toString()),
            Obx(() {
              if (flightFareRuleController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (flightFareRuleController
                    .flightFareRuleControllerModel.value.flights!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 88,
                          color: Colors.grey,
                        ),
                        Text("No Data Found",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  );
                } else {
                  var data1 = flightFareRuleController
                      .flightFareRuleControllerModel.value.flights;
                  return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data1!.length,
                          itemBuilder: (context, index) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlightPackageWidget(
                                      name: 'Saver',
                                      charges: data1[index]!.totalAmount,
                                      tax: data1[index]!.taxesAmount
                                      ),
                                ]);
                          }));
                }
              }
            }),
            // FlightPackageWidget(name: 'Saver',),
          ],
        ),
      ),
    );
  }
}
///////////////////////////// FlightPackageWidget /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class FlightPackageWidget extends StatelessWidget {
  dynamic? charges;
  dynamic? tax;
  FlightPackageWidget({
    required this.name,
    this.charges,
    this.tax,
    super.key,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
        margin: const EdgeInsets.fromLTRB(10.0, 10, 10, 10.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st ------------------------------------------
            // 0.01.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '$name \$ ${charges + tax}',
                  weight: FontWeight.bold,
                  fontSize: 20.0,
                  color: AppColors.appColorPrimary,
                ),
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (_) {},
                  activeColor: AppColors.appColorPrimary,
                )
              ],
            ),

            // -----------------------------
            0.02.ph,
            CommonText(
              text: 'Checked baggage',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '25 kg',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------

            CommonText(
              text: 'Cabin baggage',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '1 x 7 kg',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------

            CommonText(
              text: 'Change Fee',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Not Available',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------
            CommonText(
              text: 'Refund Fee',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$ Not Available',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            0.02.ph,
            //---------------------------------------
            CommonText(
              text: 'Seat Selection',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Not Available',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            CommonText(
              text: 'Upgrade to Business',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Not Available',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
              ],
            ),

            0.04.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            Divider(),
            CommonText(
              text: 'Ticket Charges',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$ $charges',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
              ],
            ),

            0.02.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            CommonText(
              text: 'Total Tax',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$ $tax',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
              ],
            ),

            0.01.ph, Divider(),
// -----------------------------------------------------
            // -----------------------------------------------------
            CommonText(
              text: 'Gross Total',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$${charges + tax}',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),
            Divider(),
            0.04.ph,
// -----------------------------------------------------

            CustomButton(
                height: 35,
                width: w,
                text: 'Avail this Flight for \$${charges + tax}',
                onPress: () {
                  Get.to(() => PassengerDetailsScreen());
                }),
          ],
        ),
      ),
    );
  }
}
