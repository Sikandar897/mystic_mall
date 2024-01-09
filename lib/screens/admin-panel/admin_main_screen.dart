import 'package:flutter/material.dart';
import 'package:mystic_mall/utils/app_constant.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         backgroundColor: AppConstant.appMainColor,
        foregroundColor: Colors.white,
        title: const Text('Admin Panel'),
      ),
    );
  }
}