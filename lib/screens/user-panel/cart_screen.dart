import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        foregroundColor: AppConstant.appTextColor,
        title: const Text('Cart Scrreen'),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: AppConstant.appTextColor,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppConstant.appMainColor,
                      child: Text('img'),
                    ),
                    title: const Text('New Dress Woman'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('2000'),
                        SizedBox(
                          width: Get.width / 20.0,
                        ),
                        const CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          radius: 14.0,
                          child: Text('+'),
                        ),
                        SizedBox(
                          width: Get.width / 20.0,
                        ),
                        const CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          radius: 14.0,
                          child: Text('-'),
                        )
                      ],
                    ),
                  ),
                );
              })),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Total',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),),
            ),
            const Text('PKR 12,00', style: TextStyle(fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondoryColor,
                          borderRadius: BorderRadius.circular(21.0)),
                      width: Get.width / 2.0,
                      height: Get.height / 18,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
