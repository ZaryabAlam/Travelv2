// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/presentation/agency/view/agency_profile_screen.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/search_view.dart';
import 'package:travel_app/presentation/booking_history/view/my_bookings_screen.dart';
import 'package:travel_app/presentation/profile/view/user_profile_screen.dart';

import '../../../app/data/data_controller.dart';
import '../../auth/view/login_screen.dart';

class BottomNavScreen extends StatefulWidget {
  BottomNavScreen({this.fromDetails = false, super.key, this.cabinClass});
  final bool? fromDetails;
  final String? cabinClass;

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final DataController dataController = Get.put(DataController());
  var tabsList = [];

  @override
  void initState() {
    setArgs();
    dataController.loadMyData();
    super.initState();
  }

  setArgs() {
    // print("Cabin Class: ${widget.cabinClass}");
    tabsList = [
      // const HomeScreen(),
      SearchScreen(cabinClass: widget.cabinClass),
      const BookingScreen(),
      // const CheckInScreen(),
      const UserProfileScreen(),
    ];
    if (widget.fromDetails!) {
      onSelectTab(1);
    }
  }

  int selectedIndex = 0;

  onSelectTab(int index) => setState(() => selectedIndex = index);

  var tabsLables = [
    // 'Home',
    'Search',
    'My Bookings',
    // 'Check-Ins',
    'User Profile',
  ];
  var tabsIcons = <Widget>[
    // const Icon(Icons.home),
    const Icon(FontAwesomeIcons.plane),
    const Icon(Icons.calendar_month_rounded),
    // const Icon(Icons.location_on),
    const Icon(Icons.person_rounded),
  ];

  List<Map<String, dynamic>> appDrawerData = [
    // {'Icon': Icons.home, 'Name': 'Home'},
    {'Icon': Icons.arrow_back_sharp, 'Name': 'Book a flight'},
    {'Icon': Icons.arrow_back_sharp, 'Name': 'My Bookings'},
    {'Icon': Icons.arrow_back_sharp, 'Name': 'Check-Ins'},
    {'Icon': Icons.arrow_back_sharp, 'Name': 'User Profile'},
    // {'Icon': Icons.settings, 'Name': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorPrimaryDark,
      appBar: CustomAppBar(title: tabsLables[selectedIndex]),

      // AppBar(
      //   shadowColor: Colors.transparent,
      //   elevation: 0.0,
      //   title: CommonText(text: tabsLables[selectedIndex], weight: AppFontWeights.appTextFontWeightBold, fontSize: 20.0),
      // ),
      // --------------------------------
      drawer: Drawer(
        backgroundColor: AppColors.appColorWhite,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.02.ph,
               CommonText(
                text: 'Hello ${dataController.myName.value}',
                fontSize: 20.0,
              ),
              0.02.ph,
              Column(
                children: List.generate(appDrawerData.length, (i) {
                  var item = appDrawerData[i];
                  return ListTile(
                    dense: true,
                    onTap: () {
                      if (i < tabsList.length) {
                        onSelectTab(i);
                      }
                      Get.back();
                    },
                    leading: Icon(item['Icon']),
                    title: CommonText(text: item['Name']),
                    subtitle: const Divider(),
                  );
                }),
              ),
              ListTile(
                dense: true,
                onTap: () async {
                  Get.to(() => AgencyProfileScreen());
                },
                leading: Icon(
                  Icons.arrow_back_sharp,
                ),
                title: CommonText(text: "Agency"),
                subtitle: const Divider(),
              ),
              ListTile(
                dense: true,
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('loggedInStatus', false);
                  Get.offAll(() => LoginScreen());
                },
                leading: Icon(
                  Icons.logout,
                ),
                title: CommonText(text: "Logout"),
                subtitle: const Divider(),
              )
            ],
          ),
        ),
        // width: 50.0,
      ),

      // --------------------------------
      body: tabsList[selectedIndex],
      // --------------------------------
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (index) => onSelectTab(index),
        backgroundColor: AppColors.appColorPrimaryDark,
        selectedItemColor: AppColors.appColorPrimary,
        unselectedItemColor: AppColors.appColorSeparator,
        items: List.generate(tabsIcons.length, (ind) {
          return BottomNavigationBarItem(
              icon: tabsIcons[ind], label: '' //tabslables[ind]
              );
        }),
      ),
    );
  }
}
