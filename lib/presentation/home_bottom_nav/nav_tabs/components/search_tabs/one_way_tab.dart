// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/return_tab.dart';

import '../../../../../app/configs/app_colors.dart';
import '../../../../../app/utils/custom_widgets/custom_toast.dart';
import '../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../../views/oneWay_flights.dart';

class OneWayTabView extends StatefulWidget {
  String? toCity;
  String? fromCity;
  String? cabinClass;
  OneWayTabView({super.key, this.toCity, this.fromCity, this.cabinClass});

  @override
  State<OneWayTabView> createState() => _OneWayTabViewState();
}

class _OneWayTabViewState extends State<OneWayTabView> {
  String? _cabinClass;
  String? selectedCabin;
  var selectedTraveller = 'Adult';
  String? selectedChildAge1 = '3-6';
  String? selectedChildAge2 = '3-6';
  String? selectedChildAge3 = '3-6';
  String? selectedChildAge4 = '3-6';
  var selectedInfantAge = '0-1';
  int adultCount = 1;
  int childCount = 0;
  int infantCount = 0;
  TextEditingController adultController = TextEditingController(text: "1");
  TextEditingController childController = TextEditingController(text: "0");
  TextEditingController infantController = TextEditingController(text: "0");

  @override
  void initState() {
    setArgs();
    super.initState();
  }

  setArgs() {
    _cabinClass = widget.cabinClass;
    selectedCabin = _cabinClass.toString();
    print("Return Tabe Cabin: ${widget.cabinClass}");
  }

  var travellerList = [
    'Adult',
    'Child',
    'Infant',
  ];
  var cabinList = [
    'Economy',
    'Business',
    // 'Premium',
    // 'First Class',
  ];
  var childAgeList = [
    '3-6',
    '6-9',
    '9-12',
  ];
  var infantAgeList = [
    '0-1',
    '1-2',
    '2-3',
  ];
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? tripType = "OneWay";

  Future<void> _selectDepartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != departDate) {
      setState(() {
        departDate = _formatDate(picked).toString();
        departDateForm = _formatDateForm(picked).toString();
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('E, d MMM y').format(date);
  }

  String _formatDateForm(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // flight time widgets --------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _selectDepartDate(context);
                },
                child: FlightTimeWidget(
                  type: 'DEPARTURE',
                  date: '$departDate',
                ),
              ),
            ],
          ),

          // Traveller ------------------------------------
          0.04.ph,
          CommonText(text: 'TRAVELLER', fontSize: 12.0),
            Counter(
              title: "Adult",
              onInc: () {
                setState(() {
                  if (adultCount < 4) {
                    adultCount++;
                  }
                  childCount = 0;
                  infantCount = 0;
                });
              },
              onDec: () {
                setState(() {
                  if (adultCount > 1) {
                    adultCount--;
                  }
                  childCount = 0;
                  infantCount = 0;
                });
              },
              count: adultCount),
          //
          0.01.ph,
          //
          Counter(
              title: "Child",
              onInc: () {
                setState(() {
                  if (childCount < adultCount) {
                    childCount++;
                  }
                });
              },
              onDec: () {
                setState(() {
                  if (childCount > 0) {
                    childCount--;
                  }
                });
              },
              count: childCount),
          childCount == 1
              ? ageDropdown("Child 1 Age", selectedChildAge1)
              : Container(),
          childCount == 2
              ? Column(children: [
                  ageDropdown("Child 1 Age", selectedChildAge1),
                  ageDropdown("Child 2 Age", selectedChildAge2),
                ])
              : Container(),
          childCount == 3
              ? Column(children: [
                  ageDropdown("Child 1 Age", selectedChildAge1),
                  ageDropdown("Child 2 Age", selectedChildAge2),
                  ageDropdown("Child 3 Age", selectedChildAge3),
                ])
              : Container(),
          childCount == 4
              ? Column(children: [
                  Column(children: [
                    ageDropdown("Child 1 Age", selectedChildAge1),
                    ageDropdown("Child 2 Age", selectedChildAge2),
                    ageDropdown("Child 3 Age", selectedChildAge3),
                    ageDropdown("Child 4 Age", selectedChildAge4),
                  ])
                ])
              : Container(),
          //

          0.01.ph,
          //
          Counter(
              title: "Infant",
              onInc: () {
                setState(() {
                  if (infantCount < adultCount) {
                    infantCount++;
                  }
                });
              },
              onDec: () {
                setState(() {
                  if (infantCount > 0) {
                    infantCount--;
                  }
                });
              },
              count: infantCount),

          // Container(
          //   height: 80,
          //   // color: Colors.red,
          //   child: Center(
          //       child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Column(
          //         children: [
          //           CommonText(
          //               text: "Adult ", weight: FontWeight.bold, fontSize: 10),
          //           Container(
          //             height: 60,
          //             width: 60,
          //             child: TextField(
          //               controller: adultController,
          //               keyboardType: TextInputType.number,
          //               textAlign: TextAlign.center,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           CommonText(
          //               text: "Child ", weight: FontWeight.bold, fontSize: 10),
          //           Container(
          //             height: 60,
          //             width: 60,
          //             child: TextField(
          //               controller: childController,
          //               keyboardType: TextInputType.number,
          //               textAlign: TextAlign.center,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           CommonText(
          //               text: "Infant ", weight: FontWeight.bold, fontSize: 10),
          //           Container(
          //             height: 60,
          //             width: 60,
          //             child: TextField(
          //               controller: infantController,
          //               keyboardType: TextInputType.number,
          //               textAlign: TextAlign.center,
          //               decoration: InputDecoration(
          //                 border: OutlineInputBorder(),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   )),
          // ),

          // SizedBox(
          //   width: w,
          //   child: DropdownButton(
          //       isDense: true,
          //       isExpanded: true,
          //       icon: Icon(Icons.arrow_drop_down),
          //       value: selectedTraveller,
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          //       items: travellerList.map((String item) {
          //         return DropdownMenuItem(
          //             value: item, child: CommonText(text: item));
          //       }).toList(),
          //       onChanged: (String? val) {
          //         setState(() => selectedTraveller = val!);
          //       }),
          // ),

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
                  return DropdownMenuItem(
                      value: item, child: CommonText(text: item));
                }).toList(),
                onChanged: (String? val) {
                  setState(() => selectedCabin = val!);
                }),
          ),

          // Search Flight Button -----------------------------------
          Spacer(),
          CustomButton(
            height: 40,
            width: w,
            text: 'Search Flight',
            onPress: () {
              if (widget.toCity == "" ||
                  widget.fromCity == "" ||
                  departDate == "Select Date" ||
                  departDate == "") {
                Get.showSnackbar(gradientSnackbar(
                    "Incomplete Form",
                    "Please fill the form correctly",
                    AppColors.orange,
                    Icons.warning_rounded));
              }  else if (int.parse(childController.text) >
                      int.parse(adultController.text) ||
                  int.parse(infantController.text) >
                      int.parse(adultController.text)) {
                MyToast.snackToast("Number of Adult must be greater", 0);
              } else {
                Get.to(() => OneWaySearchFlightScreen(
                      cabinClass: widget.cabinClass.toString(),
                      traveller: selectedTraveller.toString(),
                      toCity: widget.toCity.toString(),
                      fromCity: widget.fromCity.toString(),
                      arriveDate: null,
                      departDate: departDateForm.toString(),
                      tripType: tripType.toString(),
                      adultCount: int.parse(adultController.text),
                      childCount: int.parse(childController.text),
                      infantCount: int.parse(infantController.text),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
    Row ageDropdown(text, child) {
    return Row(
      children: [
        CommonText(text: "$text:   "),
        SizedBox(
          width: 80,
          child: DropdownButton(
              isDense: true,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              value: child.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              items: childAgeList.map((String item) {
                return DropdownMenuItem(
                    value: item, child: CommonText(text: item));
              }).toList(),
              onChanged: (String? val) {
                setState(() => child = val!);
              }),
        ),
      ],
    );
  }
}
