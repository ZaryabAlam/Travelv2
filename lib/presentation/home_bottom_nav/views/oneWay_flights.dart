import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/ticket_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/filter_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/flight_details.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/sort_view.dart';

import '../controller/oneWay_flight_quote_controller.dart';

// ignore: must_be_immutable
class OneWaySearchFlightScreen extends StatefulWidget {
  String toCity;
  String fromCity;
  String departDate;
  var arriveDate;
  String? traveller;
  String? cabinClass;
  bool? isOneWay = false;
  String tripType;

  OneWaySearchFlightScreen({
    super.key,
    required this.toCity,
    required this.fromCity,
    required this.departDate,
    required this.arriveDate,
    required this.tripType,
    this.isOneWay,
    this.traveller,
    this.cabinClass,
  });

  @override
  State<OneWaySearchFlightScreen> createState() =>
      _OneWaySearchFlightScreenState();
}

class _OneWaySearchFlightScreenState extends State<OneWaySearchFlightScreen> {
  final OneWayFlightQuoteController oneWayFlightQuoteController =
      Get.put(OneWayFlightQuoteController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      oneWayFlightQuoteController.fetchOneWayFlightQuote(widget.fromCity,
          widget.toCity, widget.departDate, widget.arriveDate, widget.tripType);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(
        title: "Search Flights",
      ),
      body: Column(
        children: [
          // Text("Tabs: ${widget.toCity}"),
          // Text("Tabs: ${widget.fromCity}"),
          // Text("Tabs: ${widget.departDate}"),
          // Text("Tabs: ${widget.arriveDate}"),
          Row(
            children: [
              Flexible(
                child: Container(
                  height: 50.0,
                  // Adjust the height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          IconTextButton(
                              onPress: () {
                                Get.to(() => SortScreen());
                              },
                              text: "Sort by",
                              icon: Icons.sort),
                        ],
                      ),
                      Row(
                        children: [
                          IconTextButton(
                              onPress: () {
                                Get.to(() => FilterScreen());
                              },
                              text: "Filter by",
                              icon: Icons.filter_list),
                        ],
                      ),
                      buildButton('Recommanded'),
                      buildButton('Low to High'),
                      buildButton('High to Low'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          0.03.ph,
          Obx(() {
            if (oneWayFlightQuoteController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (oneWayFlightQuoteController
                  .oneWayflightQuoteModel.value.flights!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        size: 88,
                        color: Colors.grey,
                      ),
                      Text("No flights available",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                );
              } else {
                var data1 = oneWayFlightQuoteController
                    .oneWayflightQuoteModel.value.flights;
                var searchData =
                    oneWayFlightQuoteController.oneWayflightQuoteModel.value;
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: data1!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DottedBorder(
                              dashPattern: [10, 8],
                              strokeWidth: 1,
                              color: AppColors.appColorBlack,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    PlaneNameWidget(
                                        image:
                                            "${data1[index].outBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                        name: data1[index]
                                            .outBound!
                                            .segments![0]
                                            .airlineName
                                            .toString(),
                                        number: data1[index]
                                            .outBound!
                                            .segments![0]
                                            .flightNumber
                                            .toString()),
                                    0.03.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FromToFlightWidget(
                                          date: data1[index]
                                              .outBound!
                                              .departureDate
                                              .toString(),
                                          time: data1[index]
                                              .outBound!
                                              .departureTime
                                              .toString(),
                                          city: data1[index]
                                              .outBound!
                                              .segments![0]
                                              .departure
                                              .toString(),
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.plane,
                                              color: AppColors.appColorPrimary,
                                              size: 20.0,
                                            ),
                                            0.01.ph,
                                            CommonText(
                                              text: 'OUT-BOUND',
                                              fontSize: 12.0,
                                            )
                                          ],
                                        ),
                                        FromToFlightWidget(
                                          date: data1[index]
                                              .outBound!
                                              .arrivalDate
                                              .toString(),
                                          time: data1[index]
                                              .outBound!
                                              .arrivalTime
                                              .toString(),
                                          city: data1[index]
                                              .outBound!
                                              .segments![0]
                                              .arrival
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    // 0.02.ph,
                                    // Divider(),
                                    // PlaneNameWidget(
                                    //     image:
                                    //         "${data1[index].inBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                    //     name: data1[index]
                                    //         .inBound!
                                    //         .segments![0]
                                    //         .airlineName
                                    //         .toString(),
                                    //     number: data1[index]
                                    //         .inBound!
                                    //         .segments![0]
                                    //         .flightNumber
                                    //         .toString()),
                                    // 0.01.ph,
                                    // data1[index].inBound != null
                                    //     ? Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           FromToFlightWidget(
                                    //             date:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .departureDate
                                    //                         .toString()
                                    //                     : "",
                                    //             time:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .departureTime
                                    //                         .toString()
                                    //                     : "",
                                    //             city:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .segments![0]
                                    //                         .departure
                                    //                         .toString()
                                    //                     : "",
                                    //           ),
                                    //           Column(
                                    //             children: [
                                    //               RotatedBox(
                                    //                 quarterTurns: 2,
                                    //                 child: Icon(
                                    //                   FontAwesomeIcons.plane,
                                    //                   color: AppColors
                                    //                       .appColorPrimary,
                                    //                   size: 20.0,
                                    //                 ),
                                    //               ),
                                    //               0.01.ph,
                                    //               CommonText(
                                    //                 text: 'IN-BOUND',
                                    //                 fontSize: 12.0,
                                    //               )
                                    //             ],
                                    //           ),
                                    //           FromToFlightWidget(
                                    //             date:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .arrivalDate
                                    //                         .toString()
                                    //                     : "",
                                    //             time:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .arrivalTime
                                    //                         .toString()
                                    //                     : "",
                                    //             city:
                                    //                 data1[index].inBound != null
                                    //                     ? data1[index]
                                    //                         .inBound!
                                    //                         .segments![0]
                                    //                         .arrival
                                    //                         .toString()
                                    //                     : "",
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : Container(),
                                    0.03.ph,
                                    CustomButton(
                                        onPress: () {
                                          Get.to(() => FlightDetailsScreen(
                                                cabinClass: widget.cabinClass
                                                    .toString(),
                                                traveller:
                                                    widget.traveller.toString(),
                                                searchID:
                                                    searchData.id.toString(),
                                                flightID: searchData
                                                    .flights![index].id!
                                                    .toString(),
                                                departFromDate1: data1[index]
                                                    .outBound!
                                                    .departureDate
                                                    .toString(),
                                                departFromTime1: data1[index]
                                                    .outBound!
                                                    .departureTime
                                                    .toString(),
                                                departFromCode1: data1[index]
                                                    .outBound!
                                                    .segments![0]
                                                    .departure
                                                    .toString(),
                                                arriveToDate1: data1[index]
                                                    .outBound!
                                                    .arrivalDate
                                                    .toString(),
                                                arriveToTime1: data1[index]
                                                    .outBound!
                                                    .arrivalTime
                                                    .toString(),
                                                arriveToCode1: data1[index]
                                                    .outBound!
                                                    .segments![0]
                                                    .arrival
                                                    .toString(),
                                                arriveFlight: "",
                                                departFlight: data1[index]
                                                    .outBound!
                                                    .segments![0]
                                                    .flightNumber
                                                    .toString(),
                                                departFromDate2: "",
                                                departFromTime2: "",
                                                departFromCode2: "",
                                                arriveToDate2: "",
                                                arriveToTime2: "",
                                                arriveToCode2: "",
                                              ));
                                        },
                                        text:
                                            "Flights starts from \$ ${data1[index].totalAmount}"),
                                    // 0.01.ph,
                                    // Align(
                                    //   alignment: Alignment.centerRight,
                                    //   child: IconButton(
                                    //       onPressed: () {
                                    //         _showAlertDialog(context);
                                    //       },
                                    //       icon: Icon(
                                    //           Icons.shopping_bag_rounded)),
                                    // )
                                  ],
                                ),
                              )),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                );
              }
            }
          }),
        ],
      ),
    );
  }

  // ignore: unused_element
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Baggage Info'),
          // content: Text('This is the content of the alert dialog.'),
          actions: <Widget>[
            // FlightPackageWidget(name: 'Saver'),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Function to be executed when the "OK" button is pressed
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class IconTextButton extends StatelessWidget {
  String text;
  IconData icon;
  final Function() onPress;
  IconTextButton({
    required this.text,
    required this.icon,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        TextButton(onPressed: onPress, child: CommonText(text: text))
      ],
    );
  }
}

// ignore: must_be_immutable
class PlaneNameWidget extends StatelessWidget {
  String name;
  String image;
  String number;
  PlaneNameWidget({
    required this.name,
    required this.image,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 30,
            width: 30,
            child: Image(image: NetworkImage(image), fit: BoxFit.contain)),
        CommonText(
          text: name,
          fontSize: 12.0,
          weight: FontWeight.w400,
        ),
        Spacer(),
        CommonText(
          text: number,
          fontSize: 12.0,
        )
      ],
    );
  }
}

Widget buildButton(String buttonText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: Text(buttonText),
    ),
  );
}
