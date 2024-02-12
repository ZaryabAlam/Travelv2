import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/gradient_snackbar.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/search_flights.dart';
import 'package:intl/intl.dart';

import '../../../../../app/configs/app_colors.dart';

// ignore: must_be_immutable
class ReturnTabView extends StatefulWidget {
  String? toCity;
  String? fromCity;
  String? cabinClass;
  ReturnTabView({super.key, this.toCity, this.fromCity, this.cabinClass});

  @override
  State<ReturnTabView> createState() => _ReturnTabViewState();
}

class _ReturnTabViewState extends State<ReturnTabView> {
  String? _cabinClass;
  String? selectedCabin;
  var selectedTraveller = 'Adult';

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
  ];
  var cabinList = [
    'Economy',
    'Business',
    'Premium',
    'First Class',
  ];

  String? arriveDate = "Select Date";
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? arriveDateForm = "Select Date";
  String? tripType = "RoundTrip";

  Future<void> _selectArriveDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != arriveDate) {
      setState(() {
        arriveDate = _formatDate(picked).toString();
        arriveDateForm = _formatDateForm(picked).toString();
      });
    }
  }

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

          // ElevatedButton(
          //   onPressed: () => _selectArriveDate(context),
          //   child: Text('Select Date'),
          // ),

          // ElevatedButton(
          //   onPressed: () => _selectDepartDate(context),
          //   child: Text('Select Date'),
          // ),

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
              InkWell(
                onTap: () {
                  _selectArriveDate(context);
                },
                child: FlightTimeWidget(
                  type: 'RETURN',
                  date: '$arriveDate',
                ),
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
                  return DropdownMenuItem(
                      value: item, child: CommonText(text: item));
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
                  departDate == "" ||
                  arriveDate == "Select Date" ||
                  arriveDateForm == "") {
                Get.showSnackbar(gradientSnackbar(
                    "Incomplete Form",
                    "Please fill the form correctly",
                    AppColors.orange,
                    Icons.warning_rounded));
              } else {
                Get.to(() => SearchFlightScreen(
                      cabinClass: widget.cabinClass.toString(),
                      traveller: selectedTraveller.toString(),
                      toCity: widget.toCity.toString(),
                      fromCity: widget.fromCity.toString(),
                      arriveDate: arriveDateForm.toString(),
                      departDate: departDateForm.toString(),
                       tripType: tripType.toString(),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}

class FlightTimeWidget extends StatelessWidget {
  const FlightTimeWidget({
    required this.type,
    required this.date,
    super.key,
  });
  final String type, date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: type,
          fontSize: 12,
        ),
        0.005.ph,
        CommonText(
          text: date, //'Fri, 28 Jan 2024',
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
