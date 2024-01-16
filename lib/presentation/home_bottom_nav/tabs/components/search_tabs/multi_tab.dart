import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/tabs/components/search_tabs/return_tab.dart';

class MultiTabView extends StatefulWidget {
  const MultiTabView({super.key});

  @override
  State<MultiTabView> createState() => _MultiTabViewState();
}

class _MultiTabViewState extends State<MultiTabView> {
  var travellerList = [
    '1 Child',
    '1 Adult',
    '1 Teenager',
    '1 Aged',
  ];
  var cabinList = [
    'Economy',
    'Business',
    'Premium',
    'First Class',
  ];

  var selectedTraveller = '1 Child';
  var selectedCabin = 'Economy';

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Container(
      // height: h * 0.3,
      // width: w,
      margin: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // flight time widgets --------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlightTimeWidget(
                  type: 'DEPARTURE',
                  date: 'Fri, 28 Jan 2024',
                ),
                FlightTimeWidget(
                  type: 'RERURN',
                  date: 'Tue, 15 Feb 2024',
                ),
              ],
            ),

            // Traveller ------------------------------------
            0.04.ph,
            CommonText(text: 'TRAVELLER', fontSize: 12.0),

            SizedBox(
              width: w,
              child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  value: selectedTraveller,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  items: travellerList.map((String item) {
                    return DropdownMenuItem(value: item, child: CommonText(text: item));
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() => selectedTraveller = val!);
                  }),
            ),

            // Cabin Class  ---------------------------------
            0.04.ph,
            CommonText(text: 'CABIN CLASS', fontSize: 12.0),

            SizedBox(
              width: w,
              child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  value: selectedCabin,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  items: cabinList.map((String item) {
                    return DropdownMenuItem(value: item, child: CommonText(text: item));
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() => selectedCabin = val!);
                  }),
            ),

            // Search Flight Button -----------------------------------

            // flight time widgets --------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlightTimeWidget(
                  type: 'DEPARTURE',
                  date: 'Fri, 28 Jan 2024',
                ),
                FlightTimeWidget(
                  type: 'RERURN',
                  date: 'Tue, 15 Feb 2024',
                ),
              ],
            ),

            // Traveller ------------------------------------
            0.04.ph,
            CommonText(text: 'TRAVELLER', fontSize: 12.0),

            SizedBox(
              width: w,
              child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  value: selectedTraveller,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  items: travellerList.map((String item) {
                    return DropdownMenuItem(value: item, child: CommonText(text: item));
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() => selectedTraveller = val!);
                  }),
            ),

            // Cabin Class  ---------------------------------
            0.04.ph,
            CommonText(text: 'CABIN CLASS', fontSize: 12.0),

            SizedBox(
              width: w,
              child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  value: selectedCabin,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  items: cabinList.map((String item) {
                    return DropdownMenuItem(value: item, child: CommonText(text: item));
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() => selectedCabin = val!);
                  }),
            ),

            // Search Flight Button -----------------------------------
            Spacer(),
            CustomButton(height: 40, width: w, text: 'Search Flight', onPress: () {}),

            // OneWayTabView()
          ],
        ),
      ),
    );
  }
}
