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
import 'package:travel_app/presentation/home_bottom_nav/views/payment_method.dart';

// ignore: must_be_immutable
class FlightDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String cabinClass;
  String traveller;
  //
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;

  FlightDetailsScreen({
    super.key,
    required this.searchID,
    required this.flightID,
    required this.cabinClass,
    required this.traveller,
    //
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    //
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    //
  });

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  final FlightFareRuleController flightFareRuleController =
      Get.put(FlightFareRuleController());

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {flightFareRuleController.fetchFareRule(widget.searchID, widget.flightID);});
   
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
                                    traveller: widget.traveller,
                                    cabinClass: widget.cabinClass,
                                    charges: data1[index]!.totalAmount,
                                    tax: data1[index]!.taxesAmount,
                                    searchID: widget.searchID,
                                    flightID: widget.flightID,
                                    departFlight: widget.departFlight,
                                    arriveFlight: widget.arriveFlight,
                                    departFromDate1: widget.departFromDate1,
                                    departFromTime1: widget.departFromTime1,
                                    departFromCode1: widget.departFromCode1,
                                    departFromDate2: widget.departFromDate2,
                                    departFromTime2: widget.departFromTime2,
                                    departFromCode2: widget.departFromCode2,
                                    arriveToDate1: widget.arriveToDate1,
                                    arriveToTime1: widget.arriveToTime1,
                                    arriveToCode1: widget.arriveToCode1,
                                    arriveToDate2: widget.arriveToDate2,
                                    arriveToCode2: widget.arriveToCode2,
                                    arriveToTime2: widget.arriveToTime2,
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
class FlightPackageWidget extends StatefulWidget {
  dynamic? charges;
  dynamic? tax;
  String searchID;
  String flightID;
  String traveller;
  String cabinClass;
//
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;

  FlightPackageWidget({
    required this.name,
    this.charges,
    this.tax,
    required this.traveller,
    required this.cabinClass,
    required this.searchID,
    required this.flightID,
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    super.key,
  });

  final String name;

  @override
  State<FlightPackageWidget> createState() => _FlightPackageWidgetState();
}

class _FlightPackageWidgetState extends State<FlightPackageWidget> {
  @override
  Widget build(BuildContext context) {
    dynamic? total = widget.charges + widget.tax!;

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
                  text: '${widget.name} \$${total.toStringAsFixed(2)}',
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
                  text: '\$ ${widget.charges}',
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
                  text: '\$ ${widget.tax}',
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
                  text: '\$${total.toStringAsFixed(2)}',
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
                text: 'Avail this Flight for \$${total.toStringAsFixed(2)}',
                onPress: () {
                  Get.to(() => PaymentMethodScreen(
                        fare: widget.charges.toString(),
                        tax: widget.tax.toString(),
                        total: total.toStringAsFixed(2),
                        traveller: widget.traveller,
                        cabinClass: widget.cabinClass,
                        searchID: widget.searchID,
                        flightID: widget.flightID,
                        departFlight: widget.departFlight,
                        arriveFlight: widget.arriveFlight,
                        departFromDate1: widget.departFromDate1,
                        departFromTime1: widget.departFromTime1,
                        departFromCode1: widget.departFromCode1,
                        departFromDate2: widget.departFromDate2,
                        departFromTime2: widget.departFromTime2,
                        departFromCode2: widget.departFromCode2,
                        arriveToDate1: widget.arriveToDate1,
                        arriveToTime1: widget.arriveToTime1,
                        arriveToCode1: widget.arriveToCode1,
                        arriveToDate2: widget.arriveToDate2,
                        arriveToCode2: widget.arriveToCode2,
                        arriveToTime2: widget.arriveToTime2,
                      ));
                  // Get.to(() => PassengerDetailsScreen(
                  //       fare: widget.charges.toString(),
                  //       tax: widget.tax.toString(),
                  //       total: total.toStringAsFixed(2),
                  //       traveller: widget.traveller,
                  //       cabinClass: widget.cabinClass,
                  //       searchID: widget.searchID,
                  //       flightID: widget.flightID,
                  //       departFlight: widget.departFlight,
                  //       arriveFlight: widget.arriveFlight,
                  //       departFromDate1: widget.departFromDate1,
                  //       departFromTime1: widget.departFromTime1,
                  //       departFromCode1: widget.departFromCode1,
                  //       departFromDate2: widget.departFromDate2,
                  //       departFromTime2: widget.departFromTime2,
                  //       departFromCode2: widget.departFromCode2,
                  //       arriveToDate1: widget.arriveToDate1,
                  //       arriveToTime1: widget.arriveToTime1,
                  //       arriveToCode1: widget.arriveToCode1,
                  //       arriveToDate2: widget.arriveToDate2,
                  //       arriveToCode2: widget.arriveToCode2,
                  //       arriveToTime2: widget.arriveToTime2,
                  //     ));
                }),
          ],
        ),
      ),
    );
  }
}
