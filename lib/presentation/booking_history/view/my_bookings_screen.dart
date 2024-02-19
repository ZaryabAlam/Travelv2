import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

import '../controller/booking_history_controller.dart';
import '../model/booking_history_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingHistoryController bookingHistoryController =
      Get.put(BookingHistoryController());
  final Rx<BookingHistoryModel> bookingHistoryModel = BookingHistoryModel().obs;
  final RxList<BookingHistoryModel> bookingHistoryList =
      <BookingHistoryModel>[].obs;
  final RxBool isLoading = false.obs;
  String? formattedDate = "";
  String? formattedTime = "";

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse the input date and time string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the time
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingHistoryController.fetchBookings();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Obx(() {
              if (bookingHistoryController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return bookingHistoryController.bookingHistoryList.isEmpty
                    ? Center(
                        child: Text('No Bookings Available'),
                      )
                    : ListView.builder(
                        itemCount:
                            bookingHistoryController.bookingHistoryList.length,
                        itemBuilder: (context, index) {
                          var bookings = bookingHistoryController
                              .bookingHistoryList[index];
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DottedBorder(
                              dashPattern: [10, 8],
                              strokeWidth: 1,
                              color: AppColors.appColorPrimary,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
                                margin: const EdgeInsets.all(20.0),
                                // height: h * 0.43,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 1st  FROM TO ------------------------------------------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CommonText(text: "ID "),
                                            CommonText(
                                              text: " ${bookings.bookingId}",
                                              weight: FontWeight.bold,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CommonText(text: " "),
                                            CommonText(
                                              text: " ${bookings.parentPnr}",
                                              weight: FontWeight.bold,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FromToFlightWidget(
                                          date: formatDate(bookings
                                              .departureDateTime
                                              .toString()),
                                          time: formatTime(bookings
                                              .departureDateTime
                                              .toString()),
                                          city: '${bookings.departure}',
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
                                              text:
                                                  bookings.tripType.toString(),
                                              fontSize: 10.0,
                                            )
                                          ],
                                        ),
                                        FromToFlightWidget(
                                          date: formatDate(bookings
                                              .arrivalDateTime
                                              .toString()),
                                          time: formatTime(bookings
                                              .arrivalDateTime
                                              .toString()),
                                          city: '${bookings.arrival}',
                                        ),
                                      ],
                                    ),
                                    0.08.ph,
                                    CommonText(
                                      text: 'Fare Information',
                                      weight: FontWeight.w600,
                                    ),
                                    0.02.ph,
                                    // CommonText(
                                    //   text: 'Adult x 01',
                                    //   fontSize: 11,
                                    // ),
                                    // 0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: 'Fare',
                                          fontSize: 11,
                                        ),
                                        CommonText(
                                          text: '\$ ${bookings.ticketAmount}',
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                    0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: 'Taxes and Fees',
                                          fontSize: 11,
                                        ),
                                        CommonText(
                                          text: '\$ ${bookings.taxAmount}',
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                    0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: 'Agency Charges',
                                          fontSize: 11,
                                        ),
                                        CommonText(
                                          text: '\$ ${bookings.agencyMarkup}',
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                    0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: 'Other Charges',
                                          fontSize: 11,
                                        ),
                                        CommonText(
                                          text: '\$ 20',
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),

                                    // 0.02.ph,
                                    Divider(color: Colors.black),

                                    0.02.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: 'Total Charges',
                                          fontSize: 11,
                                          weight: FontWeight.w700,
                                        ),
                                        CommonText(
                                          text: '\$ ${bookings.totalAmount}',
                                          fontSize: 11,
                                          weight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                    0.02.ph,
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(text: "Status"),
                                        CommonText(
                                            text: "${bookings.status}",
                                            weight: FontWeight.w500),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
            }),
          ),
        ],
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     /// Main ----------------------------------

      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(0.0),
      //     child: SearchBar(),
      //   ),
      // ),

      //     /// Search Bar ----------------------------------
      //     0.02.ph,
      //     FlightSummaryWidget(),

      //     // --------------------------------------------------
      //     0.02.ph,
      //     CommonText(
      //       text: 'Your Ticket has been Downloaded',
      //       fontSize: 18.0,
      //       weight: FontWeight.w700,
      //     ),
      //     // --------------------------------------------------
      //     // Spacer(),
      //     CustomButton(
      //         height: 40.0,
      //         width: w,
      //         text: 'Download Ticket',
      //         onPress: () {})
      //   ],
      // ),
    );
  }
}

class FlightSummaryWidget extends StatelessWidget {
  const FlightSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
        margin: const EdgeInsets.all(20.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st  FROM TO ------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FromToFlightWidget(
                  date: 'Fri 29 Dec 23',
                  time: '19:30',
                  city: 'CAI',
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
                      text: 'EK06',
                      fontSize: 12.0,
                    )
                  ],
                ),
                FromToFlightWidget(
                  date: 'Sat 29 Dec 23',
                  time: '22:30',
                  city: 'DXB',
                ),
              ],
            ),
            0.04.ph,
            CommonText(
              text: 'Fare Information',
              weight: FontWeight.w600,
            ),
            0.02.ph,
            CommonText(
              text: 'Adult x 01',
              fontSize: 11,
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Fare',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 125',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Taxes and Fees',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 2',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Extra Baggage',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 20',
                  fontSize: 11,
                ),
              ],
            ),

            0.02.ph,
            Divider(color: Colors.black),

            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Total Charges',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
                CommonText(
                  text: '\$ 147',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FromToFlightWidget extends StatelessWidget {
  const FromToFlightWidget({
    required this.time,
    required this.date,
    required this.city,
    super.key,
  });

  final String date, time, city;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: date, //'Fri 29 Dec 23',
          fontSize: 10.0,
        ),
        0.005.ph,
        CommonText(
          text: time, //'19:30',
          fontSize: 20.0,
          weight: FontWeight.bold,
        ),
        0.005.ph,
        CommonText(
          text: city, //'CAI',
          fontSize: 16.0,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.appColorPrimary.withOpacity(0.1),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search PNR',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
