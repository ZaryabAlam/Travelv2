import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var cabinList = [
    'Economy',
    'Business',
    'Premium',
    'First Class',
  ];
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
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
                      ),

                      0.02.ph,

                      // 3rd  Dotted Container -------------------------
                      SizedBox(
                        height: h * 0.3,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: EdgeInsets.only(right: 4.0),
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return DottedBorder(
                              dashPattern: [10, 8],
                              strokeWidth: 1,
                              color: AppColors.appColorPrimary,
                              child: Container(
                                margin: EdgeInsets.only(right: 4.0),
                                alignment: Alignment.topCenter,
                                padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
                                height: h * 0.27,
                                width: w * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/bb.png',
                                    ),
                                    // 0.008.ph,
                                    CommonText(
                                      text: 'Kenya',
                                      fontSize: 11.0,
                                      color: Colors.grey,
                                    ),
                                    // 0.008.ph,
                                    CommonText(
                                      text: 'Nairobi',
                                      fontSize: 13.0,
                                      weight: FontWeight.w500,
                                    ),
                                    Row(
                                      children: [
                                        CommonText(
                                          text: 'Economy Starting From ',
                                          fontSize: 11.0,
                                        ),
                                        CommonText(
                                          text: '\$125',
                                          fontSize: 11.0,
                                          weight: FontWeight.w400,
                                          color: AppColors.appColorPrimary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // 4th ICON SIGNIN Container -------------------------

                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30.0),
                          padding: const EdgeInsets.fromLTRB(30.0, 30, 20, 20),
                          // height: h * 0.22,
                          // width: w * 0.84,
                          decoration: BoxDecoration(
                            color: AppColors.appColorPrimaryDark,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 0.03.pw,
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'ICON',
                                  style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 32.0),
                                ),
                              ),
                              // 0.03.pw,
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    0.01.ph,
                                    CommonText(
                                      text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.',
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      textAlign: TextAlign.justify,
                                      maxLines: 5,
                                    ),
                                    0.03.ph,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 25.0,
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                color: AppColors.appColorPrimary,
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              child: CommonText(
                                                text: 'Sign In',
                                                color: Colors.white,
                                                weight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        0.04.pw,
                                        Expanded(
                                          flex: 3,
                                          child: InkWell(
                                            onTap: () {},
                                            child: CommonText(
                                              text: 'Learn about it more',
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              // textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 5th Image Slider Container -------------------------

                      SizedBox(
                        height: h * 0.4,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, i) {
                            return Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(bottom: 20.0),
                              margin: EdgeInsets.all(8.0),
                              height: 300,
                              width: 230,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0), image: DecorationImage(image: AssetImage('assets/images/aa.png'))),
                              child: CommonText(
                                text: cabinList[i],
                                color: Colors.white,
                                fontSize: 22.0,
                                weight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
