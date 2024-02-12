import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mystic_mall/controllers/google_sign_in_controller.dart';
import 'package:mystic_mall/utils/app_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppConstant.appTextColor,
        backgroundColor: AppConstant.appSecondoryColor,
        // title: const Text("Welcome to MysticMall",
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   fontSize: 25,
        // ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/splash-icon.json'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: const Text(
                      "  H",
                      style: TextStyle(
                          color: AppConstant.appSecondoryColor,
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    )),
                    Container(
                    margin: const EdgeInsets.only(top: 14.0),
                    child: const Text(
                      "appy",
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.bold,
                          color: AppConstant.appMainColor
                          ),
                    )),
                SizedBox(width: Get.width / 100),
                Container(
                    margin: const EdgeInsets.only(top: 14.0),
                    child: const Text(
                      "shoppin",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold,
                          color: AppConstant.appMainColor
                          ),
                    )),
                    Container(
                    margin: const EdgeInsets.only(top: 14.0),
                    child: const Text(
                      "G",
                      style: TextStyle(
                           color: AppConstant.appSecondoryColor,
                          fontSize: 30.0, fontWeight: FontWeight.bold
                          ),
                    )),
              ],
            ),
            SizedBox(height: Get.height / 25),
            Material(
                child: Container(
              decoration: BoxDecoration(
                  color: AppConstant.appSecondoryColor,
                  borderRadius: BorderRadius.circular(21.0)),
              width: Get.width / 1.2,
              height: Get.height / 12,
              child: TextButton.icon(
                  onPressed: () {
                    _googleSignInController.signWithGoogle();
                  },
                  icon: const FaIcon(FontAwesomeIcons.google,
                      color: AppConstant.appTextColor),
                  label: const Text(
                    'Sign in with google',
                    style: TextStyle(color: AppConstant.appTextColor),
                  )),
            )),
            SizedBox(height: Get.height / 50),
            Material(
                child: Container(
              decoration: BoxDecoration(
                  color: AppConstant.appSecondoryColor,
                  borderRadius: BorderRadius.circular(21.0)),
              width: Get.width / 1.2,
              height: Get.height / 12,
              child: TextButton.icon(
                  onPressed: () {
                    Get.to(const SignInScreen());
                  },
                  icon: const FaIcon(Icons.email,
                      size: 28, color: AppConstant.appTextColor),
                  label: const Text(
                    'Sign in with email',
                    style: TextStyle(color: AppConstant.appTextColor),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
