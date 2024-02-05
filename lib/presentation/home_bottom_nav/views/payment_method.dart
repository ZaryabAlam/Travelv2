import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/controller/payment_method_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/passenger_details.dart';

import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../../app/utils/custom_widgets/custom_outline_button.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../nav_tabs/model/payment_method_model.dart';

// ignore: must_be_immutable
class PaymentMethodScreen extends StatefulWidget {
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
  PaymentMethodScreen(
      {super.key,
      required this.searchID,
      required this.flightID,
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
      required this.cabinClass,
      required this.fare,
      required this.tax,
      required this.total});

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
                        Get.to(() => PassengerDetailsScreen(
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
