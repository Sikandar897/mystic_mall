import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/screens/user-panel/all_categories_screen.dart';
import 'package:mystic_mall/screens/user-panel/all_flash_sales.dart';
import 'package:mystic_mall/screens/user-panel/all_products_screen.dart';
import 'package:mystic_mall/screens/user-panel/cart_screen.dart';
import 'package:mystic_mall/utils/app_constant.dart';
import 'package:mystic_mall/widgets/all_product_widget.dart';
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
        actions:[
          GestureDetector(
            onTap: () => Get.to(const CartScreen()), 
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: const MyDrawerWidget(),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90.0,
              ),

              //Bellow is bannerwidget

              const BannerWidget(),

              //Below is heading widget for categories

              HeadingWidget(
                headingTitle: 'Categories',
                headingSubTitle: 'According to your budget',
                onTap: () {
                  Get.to(const AllCategoriesScreen());
                },
                buttonText: 'See More >',
              ),

              //Below is categoreis widget

              const CategoryWidget(),

              //Below is heading widget for flash sales

              HeadingWidget(
                headingTitle: 'Flash Sales',
                headingSubTitle: 'According to your budget',
                onTap: () => Get.to(const AllFlashSaleProductScreen()),
                buttonText: 'See More >',
              ),

              //Below is flashSales product

              const FlashSaleWidget(),

              //Below is heading widget for all products
              HeadingWidget(
                headingTitle: 'All Products',
                headingSubTitle: 'According to your budget',
                onTap: () =>  Get.to(const AllProductsScreen()),
                buttonText: 'See More >',
              ),
              
              //Below is all product 
              const AllProductsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
