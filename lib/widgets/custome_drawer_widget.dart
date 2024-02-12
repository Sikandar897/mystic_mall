import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mystic_mall/screens/user-panel/all_orders_screen.dart';
import 'package:mystic_mall/screens/user-panel/all_products_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';

import '../screens/auth-ui/welcome_screen.dart';

class MyDrawerWidget extends StatefulWidget {
  const MyDrawerWidget({super.key});

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        backgroundColor: AppConstant.appMainColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  'ItsAlexender',
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                subtitle: Text('Version 1.0.1',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appMainColor,
                  child: Text('Afri',
                      style: TextStyle(color: AppConstant.appTextColor)),
                ),
              ),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            
            //home

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Home',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: FaIcon(FontAwesomeIcons.house,
                    color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),

            //product

             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text('Product',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading:
                    const FaIcon(Icons.local_offer, color: AppConstant.appTextColor),
                trailing:
                    const Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
                    onTap: () => Get.to(const AllProductsScreen()),
              ),
            ),

            //order

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text('Order',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: const FaIcon(FontAwesomeIcons.bagShopping,
                    color: AppConstant.appTextColor),
                trailing:
                    const Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
                    onTap: () {
                      Get.back();
                      Get.to(const AllOrdersScreen());
                    },
              ),
            ),

            //Contact

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text('Contact',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: FaIcon(FontAwesomeIcons.phone,
                    color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            
            //logout
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth auth = FirebaseAuth.instance;

                  await auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text('Logout',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: const FaIcon(FontAwesomeIcons.rightFromBracket,
                    color: AppConstant.appTextColor),
                trailing: const Icon(Icons.arrow_forward,
                    color: AppConstant.appTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
