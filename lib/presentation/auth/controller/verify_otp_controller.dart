import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/auth/view/login_screen.dart';
import 'package:travel_app/presentation/auth/view/otp_screen.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';

class VerifyOtpController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> verifyOTP(String? phoneCode, String? phoneNumber) async {
    isLoading.value = true;
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({
        "mobileNo": "3223222188",
        "mobileCode": "+92",
        "microSiteClientId": 2,
        "code": "020616"
      });
      var response = await http.post(
        Uri.parse('${baseURL}api/Accounts/register/verifyOtp'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        Get.showSnackbar(gradientSnackbar("Success", "Please verify your email",
            AppColors.green, Icons.check_circle_rounded));
        isLoading.value = false;

        await Get.to(() => LoginScreen());
      } else {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        // loginModel.value = LoginModel.fromJson(jsonData);
        print("**** OTPController Response ****");
        print(" OTP Controller: $jsonData");
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
