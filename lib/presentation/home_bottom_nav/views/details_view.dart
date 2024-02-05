import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/bnb/bottom_nav_view.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.title, super.key});
  final String title;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Picture Container ------------------------------------
          Container(
            height: h * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/aa.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          // title ------------------------------------
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: CommonText(
              text: '${widget.title} Lounge',
              fontSize: 18.0,
              weight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CommonText(
              text:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
              fontSize: 12.0,
              textAlign: TextAlign.justify,
              lineHeight: 1.5,
            ),
          ),
          // CommonText(text: 'DETAILS SCREEN'),

          Spacer(),

          // Button ----------------------------

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: CustomButton(
                height: 40,
                width: w,
                text: 'Search Flight',
                onPress: () {
                  Get.to(() => BottomNavScreen(
                        cabinClass: widget.title,
                        fromDetails: true,
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
