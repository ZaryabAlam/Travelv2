import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final agentController = TextEditingController();
  final passController = TextEditingController();

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

              color: Colors.red.shade300,
              // child: Image(image:
              // AssetImage("assets/images/onboard_background.png"), fit: BoxFit.cover),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonText(text: "Login", color: Colors.white),
                  CommonText(
                      text: "Login to your account to book your flight.",
                      textAlign: TextAlign.center,
                      color: Colors.white),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Custom_textfield_required(
                              requiredLabel: "Username",
                              hint: "Enter username here",
                              controller: userController),
                          Custom_textfield_required(
                              requiredLabel: "Password",
                              hint: "Enter password here",
                              obscureText: true,
                              controller: passController),
                          CustomButton(
                              onPress: () {
                                Get.to(() => RegisterScreen());
                              },
                              text: "Login"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
