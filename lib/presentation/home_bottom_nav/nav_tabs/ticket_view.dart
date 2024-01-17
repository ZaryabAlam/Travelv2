import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Main ----------------------------------
            DottedBorder(
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
            ),

            // --------------------------------------------------
            0.02.ph,
            CommonText(
              text: 'Your Ticket has been Downloaded',
              fontSize: 18.0,
              weight: FontWeight.w700,
            ),
            // --------------------------------------------------
            Spacer(),
            CustomButton(height: 40.0, width: w, text: 'Download Ticket', onPress: () {})
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
