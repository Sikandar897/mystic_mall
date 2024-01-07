import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mystic_mall/screens/auth-ui/welcome_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart'; 
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        foregroundColor: Colors.white,
        title: Text(AppConstant.appMainName),
        actions: [
          GestureDetector(
            onTap: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();

             await googleSignIn.signOut();
              Get.offAll(WelcomeScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          ), 
        

        ],
      ),
    );
  }
}