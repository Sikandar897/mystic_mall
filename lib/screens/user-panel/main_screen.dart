import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/screens/user-panel/all_categories_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';
import 'package:mystic_mall/widgets/banner_widget.dart';
import 'package:mystic_mall/widgets/category_widget.dart';
import 'package:mystic_mall/widgets/custome_drawer_widget.dart';
import 'package:mystic_mall/widgets/flash_sales.dart';
import 'package:mystic_mall/widgets/heading_widget.dart';

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),
             
              //bannerwidget

              const BannerWidget(),

              //heading widget

              HeadingWidget(
                headingTitle: 'Categories',
                headingSubTitle: 'According to your budget',
                onTap: () {
                  Get.put(const AllCategoriesScreen());
                },
                buttonText: 'See More >',
              ),


              //categoreis widget
              const CategoryWidget(),

               //heading widget
              HeadingWidget(
                headingTitle: 'Flash Sales',
                headingSubTitle: 'According to your budget',
                onTap: () {},
                buttonText: 'See More >',
              ),

              //flashSales product

              const FlashSaleWidget()
            ],
          ),
        ),
      ),
    );
  }
}
