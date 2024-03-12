import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/presentation/home_bottom_nav/controller/payment_method_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/passenger_details.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/payment_details.dart';

import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../../app/utils/custom_widgets/custom_outline_button.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/payment_method_model.dart';

// ignore: must_be_immutable
class PaymentMethodScreen extends StatefulWidget {
  String searchID;
  String flightID;
  //
  String title;
  String firstName;
  String lastName;
  String dob;
  String nationality;
  String passNumber;
  String passExp;
  String email;
  String phone;
  String phoneCode;
  String countryCode;
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
  //
  String adult2name;
  String adult2dob;
  String adult2pass;
  String adult2passExp;
  String adult3name;
  String adult3dob;
  String adult3pass;
  String adult3passExp;
  String adult4name;
  String adult4dob;
  String adult4pass;
  String adult4passExp;
  //
  String child1name;
  String child1dob;
  String child1pass;
  String child1passExp;
  String child2name;
  String child2dob;
  String child2pass;
  String child2passExp;
  String child3name;
  String child3dob;
  String child3pass;
  String child3passExp;
  String child4name;
  String child4dob;
  String child4pass;
  String child4passExp;
  //
  String infant1name;
  String infant1dob;
  String infant1pass;
  String infant1passExp;
  String infant2name;
  String infant2dob;
  String infant2pass;
  String infant2passExp;
  String infant3name;
  String infant3dob;
  String infant3pass;
  String infant3passExp;
  String infant4name;
  String infant4dob;
  String infant4pass;
  String infant4passExp;
//
  PaymentMethodScreen({
    super.key,
    required this.searchID,
    required this.flightID,
    //
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.nationality,
    required this.passNumber,
    required this.passExp,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.countryCode,
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
    required this.total,
    //
    required this.adult2name,
    required this.adult2dob,
    required this.adult2pass,
    required this.adult2passExp,
    required this.adult3name,
    required this.adult3dob,
    required this.adult3pass,
    required this.adult3passExp,
    required this.adult4name,
    required this.adult4dob,
    required this.adult4pass,
    required this.adult4passExp,
    //
    required this.child1name,
    required this.child1dob,
    required this.child1pass,
    required this.child1passExp,
    required this.child2name,
    required this.child2dob,
    required this.child2pass,
    required this.child2passExp,
    required this.child3name,
    required this.child3dob,
    required this.child3pass,
    required this.child3passExp,
    required this.child4name,
    required this.child4dob,
    required this.child4pass,
    required this.child4passExp,
    //
    required this.infant1name,
    required this.infant1dob,
    required this.infant1pass,
    required this.infant1passExp,
    required this.infant2name,
    required this.infant2dob,
    required this.infant2pass,
    required this.infant2passExp,
    required this.infant3name,
    required this.infant3dob,
    required this.infant3pass,
    required this.infant3passExp,
    required this.infant4name,
    required this.infant4dob,
    required this.infant4pass,
    required this.infant4passExp,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());
  final Rx<PaymentMethodModel> paymentMethodModel = PaymentMethodModel().obs;
  final RxList<PaymentMethodModel> paymentMethodList =
      <PaymentMethodModel>[].obs;
  final RxBool isLoading = false.obs;
  String selectedOption = '';
  String selectedID = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      paymentMethodController.fetchMethod();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.title}");
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Method',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Obx(() {
                if (paymentMethodController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return paymentMethodController.paymentMethods.isEmpty
                      ? Center(
                          child: Text('No payment methods available.'),
                        )
                      : ListView.builder(
                          itemCount:
                              paymentMethodController.paymentMethods.length,
                          itemBuilder: (context, index) {
                            var method =
                                paymentMethodController.paymentMethods[index];
                            return PaymentOptionBox(
                              optionName: method.name.toString(),
                              icon: Icons.payments_outlined,
                              color: AppColors.appColorPrimary.withOpacity(0.4),
                              isSelected:
                                  selectedOption == method.name.toString(),
                              onSelect: () {
                                setState(() {
                                  selectedOption = method.name.toString();
                                  selectedID = method.id.toString();
                                });
                              },
                            );
                          },
                        );
                }
              }),
            ),
            Spacer(),
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
                      if (selectedID == "") {
                        Get.showSnackbar(gradientSnackbar(
                            "Payment Method",
                            "Please select any payment method",
                            AppColors.orange,
                            Icons.warning_rounded));
                      } else {
                        // Get.to(() => PassengerDetailsScreen(
                        Get.to(() => PaymentDetailsScreen(
                              countryCode: widget.countryCode,
                              dob: widget.dob,
                              email: widget.email,
                              firstName: widget.firstName,
                              lastName: widget.lastName,
                              nationality: widget.nationality,
                              passExp: widget.passExp,
                              passNumber: widget.passNumber,
                              phone: widget.phone,
                              phoneCode: widget.phoneCode,
                              title: widget.title,
                              fare: widget.fare.toString(),
                              tax: widget.tax.toString(),
                              total: widget.total.toString(),
                              traveller: widget.traveller,
                              cabinClass: widget.cabinClass,
                              searchID: widget.searchID,
                              flightID: widget.flightID,
                              paymentID: selectedID,
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
                              //
                              adult2name: widget.adult2name,
                              adult2dob: widget.adult2dob,
                              adult2pass: widget.adult2pass,
                              adult2passExp: widget.adult2passExp,
                              adult3name: widget.adult3name,
                              adult3dob: widget.adult3dob,
                              adult3pass: widget.adult3pass,
                              adult3passExp: widget.adult3passExp,
                              adult4name: widget.adult4name,
                              adult4dob: widget.adult4dob,
                              adult4pass: widget.adult4pass,
                              adult4passExp: widget.adult4passExp,
                              //
                              child1name: widget.child1name,
                              child1dob: widget.child1dob,
                              child1pass: widget.child1pass,
                              child1passExp: widget.child1passExp,
                              child2name: widget.child2name,
                              child2dob: widget.child2dob,
                              child2pass: widget.child2pass,
                              child2passExp: widget.child2passExp,
                              child3name: widget.child3name,
                              child3dob: widget.child3dob,
                              child3pass: widget.child3pass,
                              child3passExp: widget.child3passExp,
                              child4name: widget.child4name,
                              child4dob: widget.child4dob,
                              child4pass: widget.child4pass,
                              child4passExp: widget.child4passExp,
                              //
                              infant1name: widget.infant1name,
                              infant1dob: widget.infant1dob,
                              infant1pass: widget.infant1pass,
                              infant1passExp: widget.infant1passExp,
                              infant2name: widget.infant2name,
                              infant2dob: widget.infant2dob,
                              infant2pass: widget.infant2pass,
                              infant2passExp: widget.infant2passExp,
                              infant3name: widget.infant3name,
                              infant3dob: widget.infant3dob,
                              infant3pass: widget.infant3pass,
                              infant3passExp: widget.infant3passExp,
                              infant4name: widget.infant4name,
                              infant4dob: widget.infant4dob,
                              infant4pass: widget.infant4pass,
                              infant4passExp: widget.infant4passExp,
                            ));
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionBox extends StatelessWidget {
  final String optionName;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final Function onSelect;

  PaymentOptionBox({
    required this.optionName,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  activeColor: Colors.white,
                  value: optionName,
                  groupValue: isSelected ? optionName : null,
                  onChanged: (value) {
                    onSelect();
                  },
                ),
                Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  optionName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
