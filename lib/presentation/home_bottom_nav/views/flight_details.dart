import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';

class FlightDetailsScreen extends StatefulWidget {
  const FlightDetailsScreen({super.key});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Flight Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            // ---------------------------
            FlightPackageWidget(name: 'Saver'),
            0.01.ph,
            FlightPackageWidget(name: 'Flex'),
            0.01.ph,
            FlightPackageWidget(name: 'Premium'),
          ],
        ),
      ),
    );
  }
}

class FlightPackageWidget extends StatelessWidget {
  const FlightPackageWidget({
    required this.name,
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
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
        margin: const EdgeInsets.fromLTRB(20.0, 20, 20, 10.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st ------------------------------------------
            0.012.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '$name \$125',
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
                  text: '\$ 50',
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
                  text: '\$ 100',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              ],
            ),

            0.04.ph,
// -----------------------------------------------------

            CustomButton(height: 35, width: w, text: 'Avail this Flight for \$125', onPress: () {}),
          ],
        ),
      ),
    );
  }
}
