// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/utils/app_constant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //for password visibllity

  var isPasswordVisible = true.obs;

  Future<UserCredential?> signInMethod(
    String userPassword,
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Please wait ..");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword
          );

      EasyLoading.dismiss();
      return userCredential;
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondoryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
