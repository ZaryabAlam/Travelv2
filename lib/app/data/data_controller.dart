import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  RxInt myID = 1.obs;
  RxString myEmail = ''.obs;
  RxString myName = ''.obs;
  RxString myUsername = ''.obs;
  RxString myToken = ''.obs;
  RxString myRefToken = ''.obs;
  RxInt mySupportId = 1.obs;
  RxBool myLoggedIn = false.obs;

//////////////////////////////////////////////////////Get Stored Data
  Future<void> loadMyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _loggedIn = prefs.getBool('loggedInStatus') ?? false;
    int? _id = prefs.getInt('savedID') ?? 1;
    String? _email = prefs.getString('savedEmail') ?? "Error";
    String? _name = prefs.getString('savedName') ?? "Error";
    String? _username = prefs.getString('savedUsername') ?? "Error";
    String? _token = prefs.getString('savedToken') ?? "Error";
    String? _refToken = prefs.getString('savedRefToken') ?? "Error";
    int? _mySupportId = prefs.getInt("roleID") ?? 1;
    update();
    myID.value = _id;
    myLoggedIn.value = _loggedIn;
    myEmail.value = _email;
    myName.value = _name;
    myUsername.value = _username;
    myToken.value = _token;
    myRefToken.value = _refToken;
    mySupportId.value = _mySupportId;

    update();
  }
}
