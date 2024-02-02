import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/model/flight_quote_model.dart';
import '../../../../app/data/data_controller.dart';
import '../../../../app/utils/api_utility/api_url.dart';

class FlightQuoteController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var flightQuoteModel = FlightQuoteModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchFlightQuote(String departCity, String arriveCity,
      String departDate, String arriveDate) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({
        // "DepartureCity": departCity,
        // "ArrivalCity": arriveCity,
        // "DepartureDate": departDate,
        // "ReturnDate": arriveDate,
        "DepartureCity": "NBO",
        "ArrivalCity": "MGQ",
        "DepartureDate": "2024-02-05",
        "ReturnDate": "2024-02-10",
        "Adults": 1,
        "Children": 0,
        "Infants": 0,
        "CabinClass": "Economy",
        "IsFlexibleDates": true,
        "IsDirectFlight": false,
        "TripType": "RoundTrip",
        "MicrositeClientId": 2
      });
      print(departDate);
      print(departCity);
      var response = await http.post(
        Uri.parse('${baseURL}api/FlightQuote/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      flightQuoteModel.value = FlightQuoteModel.fromJson(jsonData);

      print("**** FlightQouteController Response ****");
      print("FlightQouteController Controller: ${response.body}");

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
