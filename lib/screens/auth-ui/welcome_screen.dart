import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mystic_mall/utils/app_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppConstant.appTextColor,
          backgroundColor: AppConstant.appSecondoryColor,
          title: const Text("Welcome to my App"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Lottie.asset('assets/images/splash-icon.json'),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: const Text(
                    "Happy Shopping",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: Get.height / 12),
              Material(
                  child: Container(
                decoration: BoxDecoration(
                    color: AppConstant.appSecondoryColor,
                    borderRadius: BorderRadius.circular(21.0)),
                width: Get.width / 1.2,
                height: Get.height / 12,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.google, 
                      color: AppConstant.appTextColor
                    ),
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
                    onPressed: () {},
                    icon: const FaIcon(
                      Icons.email,
                      size: 28, 
                      color: AppConstant.appTextColor
                    ),
                    label: const Text(
                      'Sign in with email',
                      style: TextStyle(color: AppConstant.appTextColor),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
