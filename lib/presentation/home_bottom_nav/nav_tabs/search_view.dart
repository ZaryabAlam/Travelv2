import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/multi_tab.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/one_way_tab.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/return_tab.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  int selectedTabIndex = 0;

  onTabSelect(int index) => setState(() => selectedTabIndex = index);

  var tabsNames = [
    'RETURN',
    'ONE-WAY',
    'MULTI-CITY',
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
                // From Field ------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.flight_takeoff_sharp,
                      color: AppColors.appColorPrimary,
                    ),
                    0.04.pw,
                    SizedBox(
                      width: w * 0.8,
                      child: CustomTextField(
                        textEditingController: fromController,
                        hintText: 'From CAI, Egypt',
                        labelText: 'From',
                      ),
                    ),
                  ],
                ),
                0.02.ph,

                // To Field ------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.flight_land_sharp,
                      color: AppColors.appColorPrimary,
                    ),
                    0.04.pw,
                    SizedBox(
                      width: w * 0.8,
                      child: CustomTextField(
                        textEditingController: toController,
                        hintText: 'To DXB, Dubai',
                        labelText: 'To',
                      ),
                    ),
                  ],
                ),

                // Tab Bar Container --------------------------------------

                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  width: w,
                  color: AppColors.appColorAccent,
                  child: DefaultTabController(
                    // initialIndex: 0,
                    length: tabsNames.length,
                    child: Column(
                      children: [
                        TabBar(
                          onTap: (index) {
                            onTabSelect(index);
                          },
                          dividerColor: Colors.transparent,
                          labelColor: AppColors.appColorWhite,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Colors.black,
                          // indicatorWeight: 2.5,
                          // indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
                          labelPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                          tabs: List.generate(tabsNames.length, (i) {
                            return Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                color: selectedTabIndex == i ? AppColors.appColorPrimary : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: CommonText(
                                text: tabsNames[i],
                                fontSize: 12.0,
                                color: selectedTabIndex == i ? Colors.white : Colors.black,
                                weight: selectedTabIndex == i ? FontWeight.w600 : FontWeight.w400,
                              ),
                            );
                          }),
                        ),
                        Container(
                          // padding: const EdgeInsets.symmetric(vertical: 20.0),
                          height: h * 0.4,
                          child: TabBarView(
                            children: [
                              ReturnTabView(),
                              OneWayTabView(),
                              MultiTabView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // CommonText(text: 'Search Screen'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
