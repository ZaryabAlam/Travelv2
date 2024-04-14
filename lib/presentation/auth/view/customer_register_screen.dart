import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/auth/view/otp_screen.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final firstNameController = TextEditingController();
  final midNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  String phoneNumber = '';
  String phoneCode = '+1';
  String countryCode = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  var isLoading = true.obs;
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

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
                        text: "Create an account",
                        color: Colors.white,
                        fontSize: 25,
                        weight: FontWeight.w600),
                    SizedBox(height: 10),
                    CommonText(
                        text: "Sign up your account",
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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "First Name",
                                    hint: "Enter First Name here",
                                    controller: userController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Middle Name",
                                    hint: "Enter Middle Name here",
                                    controller: userController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Last Name",
                                    hint: "Enter Last Name here",
                                    controller: userController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Username",
                                    hint: "Enter username here",
                                    controller: userController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Email",
                                    hint: "Enter email here",
                                    obscureText: true,
                                    controller: emailController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Password",
                                    hint: "Enter username here",
                                    controller: passController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Confirm Password",
                                    hint: "Confirm password here",
                                    obscureText: true,
                                    controller: confirmPassController),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Phone Number",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      setState(() {
                                        phoneNumber = numberController.text;
                                        phoneCode = number.dialCode!;
                                        countryCode = number.isoCode!;
                                      });
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    selectorConfig: SelectorConfig(
                                        trailingSpace: false,
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                        useEmoji: true),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                        TextStyle(color: Colors.black),
                                    initialValue: number,
                                    textFieldController: numberController,
                                    formatInput: true,
                                    cursorColor: Colors.black,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    inputBorder: UnderlineInputBorder(),
                                    inputDecoration: InputDecoration(
                                      isDense: true,
                                      icon: Icon(Icons.arrow_drop_down_rounded),
                                      hintText: "Enter Number Here",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                      border: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    onSaved: (PhoneNumber? number) {
                                      if (number != null) {
                                        print('On Saved: $number');
                                        phoneNumber = number.phoneNumber!;
                                        phoneCode = number.dialCode!;
                                        countryCode = number.isoCode!;
                                      }
                                    },
                                    validator: (inputValue) {
                                      if (inputValue!.isEmpty) {
                                        return "Enter Phone Number";
                                      }
                                      return null;
                                    }),
                                // CommonText(text: "Phone: $phoneCode $phoneNumber"),
                                SizedBox(height: 50),
                                CustomButton(
                                    onPress: () {
                                      Get.to(() => OTPScreen());
                                    },
                                    text: "Sign up"),
                                SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: CommonText(
                                      text: "Back",
                                      color: AppColors.appColorPrimary,
                                      weight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
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
