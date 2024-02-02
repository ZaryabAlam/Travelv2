import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/controller/flight_qoute_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/ticket_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/filter_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/flight_details.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/sort_view.dart';

// ignore: must_be_immutable
class SearchFlightScreen extends StatefulWidget {
  String toCity;
  String fromCity;
  String departDate;
  String arriveDate;

  SearchFlightScreen(
      {super.key,
      required this.toCity,
      required this.fromCity,
      required this.departDate,
      required this.arriveDate});

  @override
  State<SearchFlightScreen> createState() => _SearchFlightScreenState();
}

class _SearchFlightScreenState extends State<SearchFlightScreen> {
  final FlightQuoteController flightQuoteController =
      Get.put(FlightQuoteController());

  @override
  void initState() {
    super.initState();
    flightQuoteController.fetchFlightQuote(
        widget.fromCity, widget.toCity, widget.departDate, widget.arriveDate);
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              if (flightQuoteController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (flightQuoteController
                    .flightQuoteModel.value.flights!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 88,
                          color: Colors.grey,
                        ),
                        Text("No flights",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  );
                } else {
                  var data1 =
                      flightQuoteController.flightQuoteModel.value.flights;
                  return Expanded(
                    child: ListView.builder(
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
                                          name: data1[index]
                                              .outBound!
                                              .segments![0]
                                              .airlineName
                                              .toString(),
                                          image:
                                              "${data1[index].outBound!.segments![0].airlineLogo}",
                                          number: data1[index]
                                              .outBound!
                                              .segments![0]
                                              .flightNumber
                                              .toString()),
                                      0.01.ph,
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
                                                color:
                                                    AppColors.appColorPrimary,
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
                                      0.02.ph,
                                      Divider(),
                                      PlaneNameWidget(
                                          name: data1[index]
                                              .inBound!
                                              .segments![0]
                                              .airlineName
                                              .toString(),
                                          image:
                                              "${data1[index].inBound!.segments![0].airlineLogo}",
                                          number: data1[index]
                                              .inBound!
                                              .segments![0]
                                              .flightNumber
                                              .toString()),
                                      0.01.ph,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FromToFlightWidget(
                                            date: data1[index]
                                                .inBound!
                                                .departureDate
                                                .toString(),
                                            time: data1[index]
                                                .inBound!
                                                .departureTime
                                                .toString(),
                                            city: data1[index]
                                                .inBound!
                                                .segments![0]
                                                .departure
                                                .toString(),
                                          ),
                                          Column(
                                            children: [
                                              RotatedBox(
                                                quarterTurns: 2,
                                                child: Icon(
                                                  FontAwesomeIcons.plane,
                                                  color:
                                                      AppColors.appColorPrimary,
                                                  size: 20.0,
                                                ),
                                              ),
                                              0.01.ph,
                                              CommonText(
                                                text: 'IN-BOUND',
                                                fontSize: 12.0,
                                              )
                                            ],
                                          ),
                                          FromToFlightWidget(
                                            date: data1[index]
                                                .inBound!
                                                .arrivalDate
                                                .toString(),
                                            time: data1[index]
                                                .inBound!
                                                .arrivalTime
                                                .toString(),
                                            city: data1[index]
                                                .inBound!
                                                .segments![0]
                                                .arrival
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      0.03.ph,
                                      CustomButton(
                                          onPress: () {
                                            Get.to(() => FlightDetailsScreen());
                                          },
                                          text:
                                              "Economy Starts from \$ ${data1[index].totalAmount}"),
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
                          ],
                        );
                      },
                    ),
                  );
                }
              }
            }),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: 3,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             DottedBorder(
            //                 dashPattern: [10, 8],
            //                 strokeWidth: 1,
            //                 color: AppColors.appColorBlack,
            //                 child: Container(
            //                   padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            //                   margin: const EdgeInsets.all(20.0),
            //                   child: Column(
            //                     children: [
            //                       PlaneNameWidget(
            //                           name: "Aerojet Aviation",
            //                           image: "assets/icons/aerojet.png",
            //                           number: 'EK06'),
            //                       0.01.ph,
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           FromToFlightWidget(
            //                             date: 'Fri 29 Dec 23',
            //                             time: '19:30',
            //                             city: 'CAI',
            //                           ),
            //                           Column(
            //                             children: [
            //                               Icon(
            //                                 FontAwesomeIcons.plane,
            //                                 color: AppColors.appColorPrimary,
            //                                 size: 20.0,
            //                               ),
            //                               0.01.ph,
            //                               CommonText(
            //                                 text: 'NON-STOP',
            //                                 fontSize: 12.0,
            //                               )
            //                             ],
            //                           ),
            //                           FromToFlightWidget(
            //                             date: 'Sat 29 Dec 23',
            //                             time: '22:30',
            //                             city: 'DXB',
            //                           ),
            //                         ],
            //                       ),
            //                       0.03.ph,
            //                       CustomButton(
            //                           onPress: () {
            //                             Get.to(() => FlightDetailsScreen());
            //                           },
            //                           text: "Economy Starts from \$125"),
            //                       0.01.ph,
            //                       Align(
            //                         alignment: Alignment.centerRight,
            //                         child: IconButton(
            //                             onPressed: () {
            //                               _showAlertDialog(context);
            //                             },
            //                             icon: Icon(Icons.shopping_bag_rounded)),
            //                       )
            //                     ],
            //                   ),
            //                 )),
            //           ],
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Baggage Info'),
          // content: Text('This is the content of the alert dialog.'),
          actions: <Widget>[
            FlightPackageWidget(name: 'Saver'),
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
