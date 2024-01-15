import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/presentation/_home_bottom_nav/tabs/check_in_view.dart';
import 'package:travel_app/presentation/_home_bottom_nav/tabs/home_view.dart';
import 'package:travel_app/presentation/_home_bottom_nav/tabs/search_view.dart';
import 'package:travel_app/presentation/_home_bottom_nav/tabs/ticket_view.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  onSelectTab(int index) {
    setState(() => selectedIndex = index);
  }

  var tabsList = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const BookingScreen(),
    const CheckInScreen(),
  ];

  var tabsNames = [
    '',
    '',
    '',
    '',
  ];
  var tabsIcons = <Widget>[
    const Icon(Icons.home),
    const Icon(Icons.flight),
    const Icon(Icons.calendar_month_rounded),
    const Icon(Icons.location_on),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appColorPrimaryDark,
        appBar: AppBar(),
        body: tabsList[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: selectedIndex,
          onTap: (index) => onSelectTab(index),
          backgroundColor: AppColors.appColorPrimaryDark,
          selectedItemColor: AppColors.appColorPrimary,
          unselectedItemColor: AppColors.appColorSeparator,
          items: List.generate(tabsNames.length, (ind) {
            return BottomNavigationBarItem(icon: tabsIcons[ind], label: tabsNames[ind]);
          }),
        ),
      ),
    );
  }
}
