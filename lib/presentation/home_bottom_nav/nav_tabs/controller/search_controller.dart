import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../app/data/data_controller.dart';
import '../model/search_model.dart';

class SearchController1 extends GetxController {
  final DataController dataController = Get.put(DataController());
  RxString mySearch1 = ''.obs;
  RxString mySearch2 = ''.obs;
  var isLoading = false.obs;
  var searchModel = SearchModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  //////////////////////// Save Remember Me Function ////////////////////////
///////////////////////////////////////////////////////////////////////////

  Future<void> fetchSearch1(String search) async {
    mySearch1.value = search;
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({"search": search ?? "adasd"});

      var response = await http.post(
        Uri.parse('https://api.taajnetwork.com/api/Airport/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      searchModel.value = SearchModel.fromJson(jsonData);
      print("**** SearchController Response ****");
      print("Search Controller: $jsonData");

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
  
    Future<void> fetchSearch2(String search) async {
    mySearch2.value = search;
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({"search": search ?? "adasd"});

      var response = await http.post(
        Uri.parse('https://api.taajnetwork.com/api/Airport/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      searchModel.value = SearchModel.fromJson(jsonData);
      print("**** SearchController Response ****");
      print("Search Controller: $jsonData");

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
