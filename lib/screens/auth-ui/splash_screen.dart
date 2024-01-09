import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";
import "package:mystic_mall/controllers/get_user_data_controller.dart";
import "package:mystic_mall/screens/admin-panel/admin_main_screen.dart";
import "package:mystic_mall/screens/auth-ui/welcome_screen.dart";
import "package:mystic_mall/screens/user-panel/main_screen.dart";
import "package:mystic_mall/utils/app_constant.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      //it will movie the loggedin user if admin or user it will move to the desierd dashboard 
      loggedInUser(context);

    });
  }

  Future<void> loggedInUser(BuildContext context) async{
    if (user != null){

      final GetUserDataController getUserDataController = Get.put(GetUserDataController());

      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData [0]['isAdmin'] == true){
        Get.offAll(const AdminMainScreen());
      }
      else{
          Get.offAll(const MainScreen());
      }

    }
    else{
      Get.to(WelcomeScreen());
    }
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
