import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import '../controller/flight_booking_controller.dart';

class PaymentDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String paymentID;
  //
  String title;
  String firstName;
  String lastName;
  String dob;
  String nationality;
  String passNumber;
  String passExp;
  String email;
  String phone;
  String phoneCode;
  String countryCode;
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
  //
  String traveller;
  String cabinClass;
  String fare;
  String tax;
  String total;
  PaymentDetailsScreen(
      {super.key,
      required this.searchID,
      required this.flightID,
      required this.paymentID,
      //
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.nationality,
      required this.passNumber,
      required this.passExp,
      required this.email,
      required this.phone,
      required this.phoneCode,
      required this.countryCode,
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
      required this.traveller,
      required this.cabinClass,
      required this.fare,
      required this.tax,
      required this.total});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  final FlightBookingController flightBookingController =
      Get.put(FlightBookingController());

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Details',
      ),
      body: Obx(() {
        return flightBookingController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              text: 'Card Details',
                              weight: FontWeight.w600,
                              fontSize: 18.0),
                          0.03.ph,
                          Custom_textfield_required(
                              keyboardType: TextInputType.number,
                              controller: cardController,
                              requiredLabel: 'Card Number',
                              hint: 'Enter Card Number here'),
                          0.03.ph,
                          Custom_textfield_required(
                              controller: fullNameController,
                              requiredLabel: 'Full Name',
                              hint: 'Enter Full Name (Same as Card)'),
                          0.03.ph,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Date of Birth",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                      keyboardType: TextInputType.datetime,
                                      textEditingController: monthController,
                                      hintText: 'Month')),
                              Expanded(
                                  child: CustomTextField(
                                      keyboardType: TextInputType.datetime,
                                      textEditingController: yearController,
                                      hintText: 'Year')),
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
                            text:
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                            textAlign: TextAlign.justify,
                          ))
                    ]),
                  ],
                ),
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
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
                  flightBookingController.fetchBooking(
                      widget.searchID,
                      widget.flightID,
                      widget.paymentID,
                      widget.title,
                      widget.firstName,
                      widget.lastName,
                      widget.traveller,
                      widget.dob,
                      widget.passNumber,
                      widget.passExp,
                      widget.email,
                      widget.phone,
                      widget.phoneCode,
                      widget.countryCode
                      );
                })
          ],
        ),
      ),
    );
  }
}
