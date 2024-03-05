import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../views/booking_details.dart';
import '../model/flight_booking_model.dart';

class FlightBookingController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var flightBookingModel = FlightBookingModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchBooking(
      String searchID,
      String flightID,
      String paymentID,
      String title,
      String firstName,
      String lastName,
      String traveller,
      String dob,
      String passNumber,
      String passExp,
      String email,
      String phoneNum,
      String phoneCode,
      String countryCode) async {
    isLoading.value = true;
    int mySearchID = int.parse(searchID);
    int myflightID = int.parse(flightID);
    int mypaymentID = int.parse(paymentID);
    print(
        "Booking: 1 $mySearchID,2 $myflightID,3 $mypaymentID,4 $countryCode,5 $title,6 $firstName, 7 $lastName,8 $traveller, 9 $dob,10 $passNumber,11 $passExp, 12 $email ,13 $phoneNum, 14 $phoneCode, 15 $countryCode");

    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({
        "flightSelection": [
          {"flightId": myflightID, "searchId": mySearchID}
        ],
        "paymentTypeId": mypaymentID,
        "microSiteClientId": 1,
        "passengers": [
          {
            "type": "Adult",
            "firstName": firstName,
            "lastName": lastName,
            "requestedAge": 29,
            "birthDate": dob,
            "Title": "MISTER",
            "documentType": "PASSPORT",
            "documentNumber": "BD0123456",
            "documentExpiration": "2028-03-25",
            "email": "shoaibuldin123@hotmail.com",
            "phoneCountryCode": phoneCode,
            "phone": phoneNum,
            "country": countryCode,
            "countryId": 12
          }
        ]
        // "flightSelection": [
        //   {"flightId": myflightID, "searchId": mySearchID}
        // ],
        // "paymentTypeId": mypaymentID,
        // "microSiteClientId": 1,
        // "passengers": [
        //   {
        //     "type": traveller,
        //     "firstName": firstName,
        //     "lastName": lastName,
        //     "requestedAge": 29,
        //     "birthDate": "1994-03-25",
        //     "Title": title,
        //     "documentType": "PASSPORT",
        //     "documentNumber": passNumber,
        //     "documentExpiration": "2028-03-25",
        //     "email": email,
        //     "phoneCountryCode": phoneCode,
        //     "phone": phoneNum,
        //     "country": countryCode,
        //     "countryId": 12
        //   }
        // ]
      });

      var response = await http.post(
        Uri.parse('${baseURL}api/FlightBooking/addBooking'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      flightBookingModel.value = FlightBookingModel.fromJson(jsonData);

      print("**** FlightBookingController Response ****");
      print("FlightBooking Controller: ${response.body}");
      print("FlightBooking: ${jsonData["parentPnr"]}");
      String? _parentPNR = jsonData["parentPnr"].toString();
      String? _status = jsonData["status"].toString();
      if (response.statusCode == 200) {
        Get.to(() => BookingDetailsScreen(
              parentPNR: _parentPNR,
              status: _status,
            ));
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar(
            "Failure",
            "${jsonData["error"] ?? "Something went wrong"}",
            AppColors.red,
            Icons.warning_rounded));
      }
    } catch (e) {
      print('Error: $e');
      Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong",
          AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
