// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/booking_history/view/my_bookings_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/payment_method.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';

class PassengerDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String paymentID;
  //
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  String traveller;
  int? adultCount;
  int? childCount;
  int? infantCount;
  String cabinClass;
  String fare;
  String tax;
  String total;

  PassengerDetailsScreen(
      {super.key,
      required this.searchID,
      required this.flightID,
      required this.paymentID,
      //
      required this.departFlight,
      required this.departFromDate1,
      required this.departFromTime1,
      required this.departFromCode1,
      required this.arriveToDate1,
      required this.arriveToTime1,
      required this.arriveToCode1,
      //
      required this.arriveFlight,
      required this.departFromDate2,
      required this.departFromTime2,
      required this.departFromCode2,
      required this.arriveToDate2,
      required this.arriveToTime2,
      required this.arriveToCode2,
      //
      required this.traveller,
      required this.adultCount,
      required this.childCount,
      required this.infantCount,
      required this.cabinClass,
      required this.fare,
      required this.tax,
      required this.total});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController passportExpiryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final DataController dataController = Get.put(DataController());
  DateTime _selectedDate = DateTime.now();
  String? requestedAge = "";
  String phoneNumber = '';
  String phoneCode = '+1';
  String countryCode = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

  String? _selectedTitle = "Mr";
  String? _selectedCountry;
  final Map<String, String> titleMap = {
    'Mr': 'MISTER',
    'Mrs': 'MISTER',
    'Ms': 'MISTER',
    'Sir': 'MISTER',
  };

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      DatePickerMode initialDatePickerMode,
      bool isPass) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      initialDatePickerMode: initialDatePickerMode,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DatePickerMode == DatePickerMode.year
            ? "${picked.year}"
            : initialDatePickerMode == DatePickerEntryMode.calendar
                ? "${picked.month}"
                : "${picked.day}";
        if (isPass == false) {
          _updateTextControllers();
        } else {
          _updatePassExpTextControllers();
        }
      });
    }
  }

  String getMonthAbbreviation(int month) {
    final List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (month >= 1 && month <= 12) {
      return monthAbbreviations[month - 1];
    } else {
      return '';
    }
  }

  void _updateTextControllers() {
    yearController.text = "${_selectedDate.year}";
    monthController.text = getMonthAbbreviation(_selectedDate.month);
    // monthController.text = "${_selectedDate.month.toString().padLeft(2, '0')}";
    dayController.text = "${_selectedDate.day.toString().padLeft(2, '0')}";
  }

  void _updatePassExpTextControllers() {
    passportExpiryController.text =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
  }

  void init() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
    });
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Passenger Details',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      text: 'Passenger',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                  // Custom_textfield_required(
                  //     controller: titleController,
                  //     requiredLabel: 'Title',
                  //     hint: 'Mr',
                  //     validator: (inputValue) {
                  //       if (inputValue!.isEmpty) {
                  //         return "Enter Title";
                  //       }
                  //       return null;
                  //     }),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Title",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w,
                    height: 35,
                    child: DropdownButton(
                      isDense: true,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      value: _selectedTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 44.0),
                      underline: Container(
                        height: 0.7, // Specify the underline height
                        color: Colors.black26, // Specify the underline color
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTitle = newValue;
                        });
                      },
                      items: titleMap.keys
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: CommonText(
                                text: value, weight: FontWeight.w500));
                      }).toList(),
                    ),
                  ),

                  // CommonText(text: "Title: ${titleMap[_selectedTitle!]}"),
                  0.03.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Custom_textfield_required(
                            controller: firstNameController,
                            requiredLabel: 'First Name',
                            hint: 'Enter First Name',
                            validator: (inputValue) {
                              if (inputValue!.isEmpty) {
                                return "Enter First Name";
                              }
                              return null;
                            }),
                      ),
                      Expanded(
                          child: Custom_textfield_required(
                              controller: lastNameController,
                              requiredLabel: 'Last Name',
                              hint: 'Enter Last Name',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Last Name";
                                }
                                return null;
                              })),
                    ],
                  ),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Date of Birth",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CustomTextField(
                              onTap: () {
                                _selectDate(context, yearController,
                                    DatePickerMode.year, false);
                              },
                              labelText: "Year",
                              textEditingController: yearController,
                              readOnly: true,
                              hintText: 'Year',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Year";
                                }
                                return null;
                              })),
                      Expanded(
                          child: CustomTextField(
                              labelText: "Month",
                              readOnly: true,
                              textEditingController: monthController,
                              hintText: 'Month',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Month";
                                }
                                return null;
                              })),
                      Expanded(
                          child: CustomTextField(
                              labelText: "Day",
                              readOnly: true,
                              textEditingController: dayController,
                              hintText: 'Day',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Day";
                                }
                                return null;
                              })),
                    ],
                  ),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Nationality",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      textEditingController: nationalityController,
                      hintText: 'Enter Nationality Here',
                      readOnly: true,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            setState(() {
                              _selectedCountry =
                                  "${country.flagEmoji}   ${country.name}";
                              nationalityController.text =
                                  _selectedCountry.toString();
                              number =
                                  PhoneNumber(isoCode: country.countryCode);
                            });
                          },
                        );
                      },
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Nationality";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: passportController,
                      // keyboardType: TextInputType.number,
                      requiredLabel: 'Passport Number',
                      hint: 'Enter Passport Here',
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Passport Number";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Passport Expiry",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      onTap: () {
                        _selectDate(context, passportExpiryController,
                            DatePickerMode.year, true);
                      },
                      readOnly: true,
                      textEditingController: passportExpiryController,
                      // labelText: 'Passport Expiry',
                      hintText: 'Enter Expiry Here',
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Passport Expiry";
                        }
                        return null;
                      }),
                  0.05.ph,
                  CommonText(
                      text: 'Contact Information',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                  Custom_textfield_required(
                      // readOnly: true,
                      controller: emailController,
                      requiredLabel: 'Email',
                      hint: dataController.myEmail.value,
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Phone Number",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          phoneNumber = numberController.text;
                          phoneCode = number.dialCode!;
                          countryCode = number.isoCode!;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                          trailingSpace: false,
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useEmoji: true),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: numberController,
                      formatInput: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: UnderlineInputBorder(),
                      inputDecoration: InputDecoration(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        hintText: "Enter Number Here",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                        border: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSaved: (PhoneNumber? number) {
                        if (number != null) {
                          print('On Saved: $number');
                          phoneNumber = number.phoneNumber!;
                          phoneCode = number.dialCode!;
                          countryCode = number.isoCode!;
                        }
                      },
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Phone Number";
                        }
                        return null;
                      }),
                  // CommonText(text: "$phoneNumber"),
                  // CommonText(text: "$phoneCode"),
                  // CommonText(text: "$countryCode"),
                  0.05.ph,
                  CommonText(
                      text: 'Flight Summary',
                      weight: FontWeight.w600,
                      fontSize: 18.0),
                  0.03.ph,
                ],
              ),
            ),
          ),
          FlightSummary(
            fare: widget.fare,
            tax: widget.tax,
            total: widget.total,
            traveller: widget.traveller,
            cabinClass: widget.cabinClass,
            searchID: widget.searchID,
            flightID: widget.flightID,
            departFlight: widget.departFlight,
            arriveFlight: widget.arriveFlight,
            departFromDate1: widget.departFromDate1,
            departFromTime1: widget.departFromTime1,
            departFromCode1: widget.departFromCode1,
            departFromDate2: widget.departFromDate2,
            departFromTime2: widget.departFromTime2,
            departFromCode2: widget.departFromCode2,
            arriveToDate1: widget.arriveToDate1,
            arriveToTime1: widget.arriveToTime1,
            arriveToCode1: widget.arriveToCode1,
            arriveToDate2: widget.arriveToDate2,
            arriveToCode2: widget.arriveToCode2,
            arriveToTime2: widget.arriveToTime2,
            adultCount: widget.adultCount,
            childCount: widget.childCount,
            infantCount: widget.infantCount,
          ),
          0.03.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomOutlineButton(
                  width: 150,
                  text: "Back",
                  onPress: () {
                    Get.back();
                  }),
              CustomButton(
                  width: 150,
                  text: "Confirm",
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        isValidForm = true;
                        // Get.to(() => PaymentDetailsScreen(
                        Get.to(() => PaymentMethodScreen(
                              title: "${titleMap[_selectedTitle!]}",
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dob:
                                  "${yearController.text}-${_selectedDate.month.toString().padLeft(2, '0')}-${dayController.text}",
                              nationality: nationalityController.text,
                              email: dataController.myEmail.value,
                              passNumber: passportController.text,
                              passExp: passportExpiryController.text,
                              phoneCode: phoneCode,
                              phone: phoneNumber,
                              countryCode: countryCode,
                              fare: widget.fare.toString(),
                              tax: widget.tax.toString(),
                              total: widget.total.toString(),
                              traveller: widget.traveller,
                              cabinClass: widget.cabinClass,
                              searchID: widget.searchID,
                              flightID: widget.flightID,
                              departFlight: widget.departFlight,
                              arriveFlight: widget.arriveFlight,
                              departFromDate1: widget.departFromDate1,
                              departFromTime1: widget.departFromTime1,
                              departFromCode1: widget.departFromCode1,
                              departFromDate2: widget.departFromDate2,
                              departFromTime2: widget.departFromTime2,
                              departFromCode2: widget.departFromCode2,
                              arriveToDate1: widget.arriveToDate1,
                              arriveToTime1: widget.arriveToTime1,
                              arriveToCode1: widget.arriveToCode1,
                              arriveToDate2: widget.arriveToDate2,
                              arriveToCode2: widget.arriveToCode2,
                              arriveToTime2: widget.arriveToTime2,
                            ));
                      });
                    } else {
                      setState(() {
                        isValidForm = false;
                      });
                    }
                  }),
            ],
          ),
          0.03.ph,
        ],
      ),
    );
  }
}

class FlightSummary extends StatefulWidget {
  String searchID;
  String flightID;
//
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  String traveller;
  String cabinClass;
  String fare;
  String tax;
  String total;
  int? adultCount;
  int? childCount;
  int? infantCount;

  FlightSummary({
    super.key,
    required this.flightID,
    required this.searchID,
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    required this.traveller,
    required this.cabinClass,
    required this.fare,
    required this.tax,
    required this.total,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
  });

  @override
  State<FlightSummary> createState() => _FlightSummaryState();
}

class _FlightSummaryState extends State<FlightSummary> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
        margin: const EdgeInsets.all(20.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st  FROM TO ------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FromToFlightWidget(
                  date: widget.departFromDate1,
                  time: widget.departFromTime1,
                  city: widget.departFromCode1,
                ),
                Column(
                  children: [
                    CommonText(
                      text: widget.departFlight,
                      fontSize: 12.0,
                    ),
                    0.01.ph,
                    Icon(
                      FontAwesomeIcons.plane,
                      color: AppColors.appColorPrimary,
                      size: 20.0,
                    ),
                    0.01.ph,
                    CommonText(
                      text: 'OUT-BOUND',
                      fontSize: 8.0,
                    )
                  ],
                ),
                FromToFlightWidget(
                  date: widget.arriveToDate1,
                  time: widget.arriveToTime1,
                  city: widget.arriveToCode1,
                ),
              ],
            ),
            0.02.ph,
            Divider(),
            0.02.ph,
            widget.arriveFlight != ""
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FromToFlightWidget(
                        date: widget.arriveToDate2,
                        time: widget.arriveToTime2,
                        city: widget.arriveToCode2,
                      ),
                      Column(
                        children: [
                          CommonText(
                            text: widget.arriveFlight,
                            fontSize: 12.0,
                          ),
                          0.01.ph,
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              FontAwesomeIcons.plane,
                              color: AppColors.appColorPrimary,
                              size: 20.0,
                            ),
                          ),
                          0.01.ph,
                          CommonText(
                            text: 'IN-BOUND',
                            fontSize: 8.0,
                          )
                        ],
                      ),
                      FromToFlightWidget(
                        date: widget.departFromDate2,
                        time: widget.departFromTime2,
                        city: widget.departFromCode2,
                      ),
                    ],
                  )
                : Container(),
            0.04.ph,
            CommonText(
              text: 'Fare Information',
              weight: FontWeight.w600,
            ),
            0.02.ph,
            CommonText(
              text: "Adult x${widget.adultCount}",
              fontSize: 11,
            ),
            0.02.ph,
            CommonText(
              text: "Child x${widget.childCount}",
              fontSize: 11,
            ),
            0.02.ph,
            CommonText(
              text: "Infant x${widget.infantCount}",
              fontSize: 11,
            ),
            0.02.ph,
            CommonText(
              text: widget.cabinClass,
              fontSize: 11,
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Fare',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ ${widget.fare}',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Taxes and Fees',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ ${widget.tax}',
                  fontSize: 11,
                ),
              ],
            ),

            0.02.ph,
            Divider(color: Colors.black),

            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Total Charges',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
                CommonText(
                  text: '\$ ${widget.total}',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
