import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/controller/flight_qoute_controller.dart';
import 'package:travel_app/presentation/booking_history/view/my_bookings_screen.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/filter_view.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/flight_details.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/sort_view.dart';

// ignore: must_be_immutable
class SearchFlightScreen extends StatefulWidget {
  String toCity;
  String fromCity;
  String departDate;
  var arriveDate;
  String? traveller;
  String? cabinClass;
  bool? isOneWay = false;
  String tripType;

  SearchFlightScreen({
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
  State<SearchFlightScreen> createState() => _SearchFlightScreenState();
}

class _SearchFlightScreenState extends State<SearchFlightScreen> {
  final FlightQuoteController flightQuoteController =
      Get.put(FlightQuoteController()); // void sortAscending() {
  //   setState(() {
  //     doubleValues.sort();
  //   });
  // }

  // void sortDescending() {
  //   setState(() {
  //     doubleValues.sort((a, b) => b.compareTo(a));
  //   });
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      flightQuoteController.fetchFlightQuote(widget.fromCity, widget.toCity,
          widget.departDate, widget.arriveDate, widget.tripType);
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
          // 0.03.ph,
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
                      Text("No flights available",
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
                var searchData = flightQuoteController.flightQuoteModel.value;
                // Function to sort flights by total amount in ascending order
                void sortAscending() {
                  setState(() {
                    data1!
                        .sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDescending() {
                  setState(() {
                    data1!
                        .sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDurationLess() {
                  setState(() {
                    data1!.sort((a, b) =>
                        a.outBound!.duration!.compareTo(b.outBound!.duration));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDurationHigh() {
                  setState(() {
                    data1!.sort((a, b) =>
                        b.outBound!.duration!.compareTo(a.outBound!.duration!));
                  });
                }

                void _showSortOptions() {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              enabled: false,
                              leading: Icon(Icons.sort),
                              title: Text('Sort by'),
                              onTap: () {},
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.stars),
                              title: Text('Recommanded'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_upward),
                              title: Text('Price (Low to High)'),
                              onTap: () {
                                sortAscending();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_downward),
                              title: Text('Price (High to Low)'),
                              onTap: () {
                                sortDescending();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.av_timer_rounded),
                              title: Text('Duration (Low to High)'),
                              onTap: () {
                                sortDurationLess();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.more_time_rounded),
                              title: Text('Duration (High to Low)'),
                              onTap: () {
                                sortDurationHigh();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 50.0,
                              // Adjust the height as needed
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        IconTextButton(
                                            onPress: () {
                                              // Get.to(() => SortScreen());
                                              _showSortOptions();
                                            },
                                            text: "Sort by",
                                            icon: Icons.sort),
                                        buildButton(
                                            text: 'Recommanded',
                                            onPress: () {}),
                                        buildButton(
                                            text: 'Low to High',
                                            onPress: () {
                                              sortAscending();
                                            }),
                                        buildButton(
                                            text: 'High to Low',
                                            onPress: () {
                                              sortDescending();
                                            }),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     IconTextButton(
                                  //         onPress: () {
                                  //           Get.to(() => FilterScreen());
                                  //         },
                                  //         text: "Filter by",
                                  //         icon: Icons.filter_list),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
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
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                                                    color: AppColors
                                                        .appColorPrimary,
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
                                              image:
                                                  "${data1[index].inBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                              name: data1[index]
                                                  .inBound!
                                                  .segments![0]
                                                  .airlineName
                                                  .toString(),
                                              number: data1[index]
                                                  .inBound!
                                                  .segments![0]
                                                  .flightNumber
                                                  .toString()),
                                          0.01.ph,
                                          data1[index].inBound != null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    FromToFlightWidget(
                                                      date: data1[index]
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .departureDate
                                                              .toString()
                                                          : "",
                                                      time: data1[index]
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .departureTime
                                                              .toString()
                                                          : "",
                                                      city: data1[index]
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .segments![0]
                                                              .departure
                                                              .toString()
                                                          : "",
                                                    ),
                                                    Column(
                                                      children: [
                                                        RotatedBox(
                                                          quarterTurns: 2,
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .plane,
                                                            color: AppColors
                                                                .appColorPrimary,
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
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .arrivalDate
                                                              .toString()
                                                          : "",
                                                      time: data1[index]
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .arrivalTime
                                                              .toString()
                                                          : "",
                                                      city: data1[index]
                                                                  .inBound !=
                                                              null
                                                          ? data1[index]
                                                              .inBound!
                                                              .segments![0]
                                                              .arrival
                                                              .toString()
                                                          : "",
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          0.03.ph,
                                          CustomButton(
                                              onPress: () {
                                                Get.to(() =>
                                                    FlightDetailsScreen(
                                                      cabinClass: widget
                                                          .cabinClass
                                                          .toString(),
                                                      traveller: widget
                                                          .traveller
                                                          .toString(),
                                                      searchID: searchData.id
                                                          .toString(),
                                                      flightID: searchData
                                                          .flights![index].id!
                                                          .toString(),
                                                      departFromDate1:
                                                          data1[index]
                                                              .outBound!
                                                              .departureDate
                                                              .toString(),
                                                      departFromTime1:
                                                          data1[index]
                                                              .outBound!
                                                              .departureTime
                                                              .toString(),
                                                      departFromCode1:
                                                          data1[index]
                                                              .outBound!
                                                              .segments![0]
                                                              .departure
                                                              .toString(),
                                                      arriveToDate1:
                                                          data1[index]
                                                              .outBound!
                                                              .arrivalDate
                                                              .toString(),
                                                      arriveToTime1:
                                                          data1[index]
                                                              .outBound!
                                                              .arrivalTime
                                                              .toString(),
                                                      arriveToCode1:
                                                          data1[index]
                                                              .outBound!
                                                              .segments![0]
                                                              .arrival
                                                              .toString(),
                                                      arriveFlight: data1[index]
                                                          .inBound!
                                                          .segments![0]
                                                          .flightNumber
                                                          .toString(),
                                                      departFlight: data1[index]
                                                          .outBound!
                                                          .segments![0]
                                                          .flightNumber
                                                          .toString(),
                                                      departFromDate2:
                                                          data1[index]
                                                              .inBound!
                                                              .departureDate
                                                              .toString(),
                                                      departFromTime2:
                                                          data1[index]
                                                              .inBound!
                                                              .departureTime
                                                              .toString(),
                                                      departFromCode2:
                                                          data1[index]
                                                              .inBound!
                                                              .segments![0]
                                                              .departure
                                                              .toString(),
                                                      arriveToDate2:
                                                          data1[index]
                                                              .inBound!
                                                              .arrivalDate
                                                              .toString(),
                                                      arriveToTime2:
                                                          data1[index]
                                                              .inBound!
                                                              .arrivalTime
                                                              .toString(),
                                                      arriveToCode2:
                                                          data1[index]
                                                              .inBound!
                                                              .segments![0]
                                                              .arrival
                                                              .toString(),
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
                                SizedBox(height: 5),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
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

class buildButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const buildButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(text),
      ),
    );
  }
}
