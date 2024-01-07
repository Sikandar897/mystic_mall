import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/controllers/sign_up_controller.dart';
import 'package:mystic_mall/screens/auth-ui/sign_in_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  //text editing controller

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, bool isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: AppConstant.appTextColor,
            centerTitle: true,
            backgroundColor: AppConstant.appSecondoryColor,
            title: const Text('Sign Up'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Welcome to MysticMall',
                        style: TextStyle(
                            color: AppConstant.appSecondoryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: userName,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'User Name',
                            prefixIcon: const Icon(Icons.person),
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
                      child: TextField(
                        controller: userPhone,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            prefixIcon: const Icon(Icons.phone),
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
                      child: TextField(
                        controller: userCity,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'City',
                            prefixIcon: const Icon(Icons.location_pin),
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
                      child: TextField(
                        controller: userEmail,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'email',
                            prefixIcon: const Icon(Icons.email),
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

                            //obsecure visable and hide

                            obscureText:
                                signUpController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondoryColor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: 'password',
                                prefixIcon: const Icon(Icons.lock),
                                suffix: GestureDetector(
                                    onTap: () {
                                      signUpController.isPasswordVisible
                                          .toggle();
                                    },
                                    child:
                                        signUpController.isPasswordVisible.value
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
                    child: const Text('Forget password?',
                        style: TextStyle(
                            color: AppConstant.appSecondoryColor,
                            fontWeight: FontWeight.bold)),
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
                          String name = userName.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String password = userPassword.text.trim();
                          String userDeviceToken = '';

                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              city.isEmpty ||
                              password.isEmpty) {
                            Get.snackbar(
                                "Error", "Please enter required details!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondoryColor,
                                colorText: AppConstant.appTextColor);
                          } else {
                            UserCredential? userCredential =
                                await signUpController.signUpMethod(name, email,
                                    phone, city, password, userDeviceToken);

                            if (userCredential != null) {
                              Get.snackbar("Verification email sent",
                                  "Please check your email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.appSecondoryColor,
                                  colorText: AppConstant.appTextColor);

                              FirebaseAuth.instance.signOut();
                              Get.offAll(const SignInScreen());
                            }
                          }
                        },
                        child: const Text(
                          'Sign Up',
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
                        "Already have an account? ",
                        style: TextStyle(color: AppConstant.appSecondoryColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAll(const SignInScreen()),
                        child: const Text(
                          "Sign In",
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
