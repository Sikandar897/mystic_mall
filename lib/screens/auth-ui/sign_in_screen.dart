// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mystic_mall/controllers/get_user_data_controller.dart';
import 'package:mystic_mall/controllers/sign_in_controller.dart';
import 'package:mystic_mall/screens/admin-panel/admin_main_screen.dart';
import 'package:mystic_mall/screens/auth-ui/forget_password_screen.dart';
import 'package:mystic_mall/screens/auth-ui/sign_up_screen.dart';
import 'package:mystic_mall/screens/user-panel/main_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';

//itsElexender friday jan, 5 2024 (OFF)

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //sign In Controller
  final SignInController signInController = Get.put(SignInController());

  //get user controller
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  //text editing controller

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, bool isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: AppConstant.appTextColor,
            centerTitle: true,
            backgroundColor: AppConstant.appSecondoryColor,
            title: const Text('Sign In'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  isKeyboardVisible
                      ? const Text('Welcome to MysticMall')
                      : Column(
                          children: [
                            Lottie.asset('assets/images/splash-icon.json')
                          ],
                        ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: userEmail,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'email',
                            prefixIcon: const Icon(Icons.email),
                            prefixIconColor: AppConstant.appSecondoryColor,
                            contentPadding:
                                const EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => TextField(
                            controller: userPassword,
                            obscureText:
                                signInController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondoryColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: 'password',
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: AppConstant.appSecondoryColor,
                                suffix: GestureDetector(
                                    onTap: () {
                                      signInController.isPasswordVisible
                                          .toggle();
                                    },
                                    child:
                                        signInController.isPasswordVisible.value
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility)),
                                contentPadding:
                                    const EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const ForgetPasswordScreen());
                      },
                      child: const Text('Forget password?',
                          style: TextStyle(
                              color: AppConstant.appSecondoryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Material(
                      child: Container(
                    decoration: BoxDecoration(
                        color: AppConstant.appSecondoryColor,
                        borderRadius: BorderRadius.circular(21.0)),
                    width: Get.width / 2,
                    height: Get.height / 18,
                    child: TextButton(
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                                "Error", "Please enter required details!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondoryColor,
                                colorText: AppConstant.appTextColor);
                          } else {
                            UserCredential? userCredential =
                                await signInController.signInMethod(
                                    email, password);

                            var userData =
                                await getUserDataController.getUserData(
                                    userCredential!.user!.uid); //uniqueId

                            if (userCredential != null) {
                              if (userCredential.user!.emailVerified) {
                                if (userData[0]['isAdmin'] == true) {
                                  Get.offAll(const AdminMainScreen());

                                  Get.snackbar("Success Admin Login",
                                      "Login Successfully!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          AppConstant.appSecondoryColor,
                                      colorText: AppConstant.appTextColor);
                                } else {
                                  Get.offAll(const MainScreen());
                                  Get.snackbar("Success User Login",
                                      "Login Successfully!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          AppConstant.appSecondoryColor,
                                      colorText: AppConstant.appTextColor);
                                }
                              } else {
                                Get.snackbar("Error",
                                    "Please verify your email before login",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        AppConstant.appSecondoryColor,
                                    colorText: AppConstant.appTextColor);
                              }
                            } else {
                              Get.snackbar("Error", "Please try again!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.appSecondoryColor,
                                  colorText: AppConstant.appTextColor);
                            }
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: AppConstant.appTextColor),
                        )),
                  )),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: AppConstant.appSecondoryColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.off(const SignUpScreen()),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppConstant.appSecondoryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
