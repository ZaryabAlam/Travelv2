import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/auth/register_screen.dart';

import '../../app/utils/custom_widgets/custom_outline_button_Wicon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final agentController = TextEditingController();
  final passController = TextEditingController();
  bool isButton1Selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.withOpacity(0.5),
            Colors.black.withOpacity(0.5),
          ],
        )),
        child: Stack(
          children: [
            Container(
              height: 550,
              width: double.infinity,
              // color: Colors.red.shade300,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.5),
                  BlendMode.srcATop,
                ),
                child: Image(
                    image: AssetImage("assets/images/onboard_background.png"),
                    fit: BoxFit.cover),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 100),
                    CommonText(
                        text: "Login",
                        color: Colors.white,
                        fontSize: 25,
                        weight: FontWeight.w600),
                    SizedBox(height: 10),
                    CommonText(
                        text: "Login to your account to book your flight.",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 15,
                        weight: FontWeight.w400),
                    SizedBox(height: 100),
                    Container(
                      // height: 400,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isButton1Selected = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    // ignore: deprecated_member_use
                                    primary: isButton1Selected
                                        ? Colors.blue
                                        : Colors.grey.shade100,
                                  ),
                                  child: CommonText(
                                    text: 'USER',
                                    color: isButton1Selected
                                        ? Colors.white
                                        : Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isButton1Selected = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: isButton1Selected
                                        ? Colors.grey.shade100
                                        : Colors.blue,
                                  ),
                                  child: CommonText(
                                      text: 'TRAVEL AGENT',
                                      color: isButton1Selected
                                          ? Colors.black54
                                          : Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            isButton1Selected
                                ? Custom_textfield_required(
                                    requiredLabel: "Username",
                                    hint: "Enter username here",
                                    controller: userController)
                                : Custom_textfield_required(
                                    requiredLabel: "Agent",
                                    hint: "Enter username here",
                                    controller: agentController),
                            SizedBox(height: 20),
                            Custom_textfield_required(
                                requiredLabel: "Password",
                                hint: "Enter password here",
                                obscureText: true,
                                controller: passController),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: CommonText(
                                      text: "Forgot Password?",
                                      color: AppColors.appColorPrimary)),
                            ),
                            SizedBox(height: 10),
                            CustomButton(
                                onPress: () {
                                  // Get.to(() => RegisterScreen());
                                },
                                text: "Login"),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 10),
                                CommonText(text: "OR"),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            CommonText(text: "Login with", color: Colors.black),
                            SizedBox(height: 20),
                            Outline_button_icon(
                              text: "Sign in with Google",
                              onPress: () {},
                              iconPath: "assets/icons/google_logo.png",
                            ),
                            SizedBox(height: 10),
                            Outline_button_icon(
                              text: "Sign in with Microsoft",
                              onPress: () {},
                              iconPath: "assets/icons/ms_logo.png",
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: CommonText(
                                      text: "Dont have an account",
                                      fontSize: 14,
                                      weight: FontWeight.w400),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => RegisterScreen());
                                    },
                                    child: CommonText(
                                      text: "Register",
                                      color: AppColors.appColorPrimary,
                                      weight: FontWeight.bold,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
