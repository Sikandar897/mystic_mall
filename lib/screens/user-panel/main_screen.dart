import 'package:flutter/material.dart';
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
      ),
    );
  }
}