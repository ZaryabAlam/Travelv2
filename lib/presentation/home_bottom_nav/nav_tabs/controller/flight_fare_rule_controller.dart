import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/model/flight_fare_rules_model.dart';
import '../../../../app/data/data_controller.dart';
import '../../../../app/utils/api_utility/api_url.dart';

class FlightFareRuleController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var flightFareRuleControllerModel = FlightFareRulesModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchFareRule(String searchID, String flightID) async {
    isLoading.value = true;
    int mySearchID = int.parse(searchID);
    int myflightID = int.parse(flightID);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({
        "flightSelection": [
          {"flightId": myflightID, "searchId": mySearchID}
        ]
      });

      var response = await http.post(
        Uri.parse('${baseURL}api/FlightFareRules'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      flightFareRuleControllerModel.value =
          FlightFareRulesModel.fromJson(jsonData);

      print("**** FlightFareRuleController Response ****");
      print("FlightFareRuleController Controller: ${response.body}");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');

      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
