import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:mystic_mall/controllers/cart_price_controller.dart';
import 'package:mystic_mall/screens/user-panel/checkout_screen.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppConstant.appTextColor,
        backgroundColor: AppConstant.appMainColor,
        title: const Text('Cart Screen'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final productData = snapshot.data!.docs[index];
                      CartModel cartModel = CartModel(
                        productId: productData['productId'],
                        categoryId: productData['categoryId'],
                        productName: productData['productName'],
                        categoryName: productData['categoryName'],
                        salePrice: productData['salePrice'],
                        fullPrice: productData['fullPrice'],
                        productImages: productData['productImages'],
                        deliveryTime: productData['deliveryTime'],
                        isSale: productData['isSale'],
                        productDescription: productData['productDescription'],
                        createdAt: productData['createdAt'],
                        updatedAt: productData['updatedAt'],
                        productQuantity: productData['productQuantity'],
                        productTotalPrice: double.parse(
                            productData['productTotalPrice'].toString()),
                      );

                      //calculate product price
                      productPriceController.fetchProductPrice();

                      //delete query
                      return SwipeActionCell(
                        key: ObjectKey(cartModel.productId),
                        trailingActions: [
                          SwipeAction(
                            title: 'Delete',
                            forceAlignmentToBoundary: true,
                            onTap: (CompletionHandler handler) async {
                              // ignore: avoid_print
                              print('deleted');
                              await FirebaseFirestore.instance
                                  .collection('cart')
                                  .doc(user!.uid)
                                  .collection('cartOrders')
                                  .doc(cartModel.productId)
                                  .delete();
                            },
                          )
                        ],
                        child: Card(
                          elevation: 5,
                          color: AppConstant.appTextColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              backgroundImage:
                                  NetworkImage(cartModel.productImages[0]),
                            ),
                            title: Text(
                              cartModel.productName,
                              style: const TextStyle(
                                color: AppConstant.appSecondoryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PKR: ${cartModel.productTotalPrice.toString()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (cartModel.productQuantity > 1) {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(user!.uid)
                                          .collection('cartOrders')
                                          .doc(cartModel.productId)
                                          .update({
                                        'productQuantity':
                                            cartModel.productQuantity - 1,
                                        'productTotalPrice':
                                            (double.parse(cartModel.fullPrice) *
                                                (cartModel.productQuantity - 1))
                                      });
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: AppConstant.appMainColor,
                                    child: Text('-',
                                        style: TextStyle(
                                            color: AppConstant.appTextColor)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  cartModel.productQuantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (cartModel.productQuantity > 0) {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(user!.uid)
                                          .collection('cartOrders')
                                          .doc(cartModel.productId)
                                          .update({
                                        'productQuantity':
                                            cartModel.productQuantity + 1,
                                        'productTotalPrice':
                                            double.parse(cartModel.fullPrice) +
                                                double.parse(cartModel.fullPrice) *
                                                    (cartModel.productQuantity)
                                      });
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: AppConstant.appMainColor,
                                    child: Text('+',
                                        style: TextStyle(
                                            color: AppConstant.appTextColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          "Total  ${productPriceController.totalPrice.value.toStringAsFixed(1)}  PKR",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstant.appSecondoryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Get.to(const CheckOutScreen());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
