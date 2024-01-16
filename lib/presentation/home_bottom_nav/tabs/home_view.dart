import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(text: 'Join Silicon Reservation System and enjoy benefits'),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: w,
              color: AppColors.appColorAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1st ------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText(text: 'FEATURED FARES FOR YOU'),
                      TextButton(
                          onPressed: () {},
                          child: const CommonText(
                            text: 'See All',
                            weight: AppFontWeights.appTextFontWeightBold,
                            color: AppColors.appColorPrimary,
                          )),
                    ],
                  ),
                  0.02.ph,
                  // 2nd ---------------------
                  Row(
                    children: [
                      const CommonText(
                        text: 'Destinations From Mogadishu',
                        weight: FontWeight.bold,
                        // color: AppColors.appColorPrimary,
                      ),
                      0.01.pw,
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.appColorPrimary,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
