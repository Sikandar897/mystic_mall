import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mystic_mall/screens/auth-ui/sign_up_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          body: Container(
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
                    child: TextField(
                      cursorColor: AppConstant.appSecondoryColor,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: const Icon(Icons.lock),
                          suffix: const Icon(Icons.visibility_off),
                          contentPadding:
                              const EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
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
                      onPressed: () {},
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
                        style: TextStyle(color: AppConstant.appSecondoryColor,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
