import 'package:flutter/material.dart';
import 'package:mystic_mall/utils/app_constant.dart';
import 'package:mystic_mall/widgets/custome_drawer_widget.dart'; 
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        foregroundColor: Colors.white,
        title: Text(AppConstant.appMainName),
        actions: const [],
      ),
      drawer: const MyDrawerWidget(),
    );
  }
}