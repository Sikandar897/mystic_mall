import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";
import "package:mystic_mall/screens/auth-ui/welcome_screen.dart";
import "package:mystic_mall/utils/app_constant.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () { 
      Get.offAll( WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    
    //same responsinves we can get through getx lets used here
    // final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppConstant.appSecondoryColor,
      body: Container(
        width: Get.width,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/images/splash-icon.json'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(AppConstant.appPowerdBy,
                  style: const TextStyle(
                      color: AppConstant.appTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
