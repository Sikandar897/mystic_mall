// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, prefer_const_declarations, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/models/cart_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/products_model.dart';
import '../../utils/app_constant.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppConstant.appTextColor,
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Product Details",
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(const CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        child: Column(
          children: [
            //product images

            SizedBox(
              height: Get.height / 60,
            ),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map(
                    (imageUrls) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrls,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) => ColoredBox(
                          color: Colors.white,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.productModel.productName,
                        style: TextStyle(
                          color: AppConstant.appSecondoryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.productModel.productDescription,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.productModel.isSale
                                ? "PKR: " + widget.productModel.salePrice
                                : "PKR: " + widget.productModel.fullPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: AppConstant.appSecondoryColor,
                            ),
                          ),
                          Icon(
                            Icons.favorite_outline,
                            color: Colors.red, // Adjust the color as needed
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.appSecondoryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          sendMessageOnWhatsapp(
                            productModel: widget.productModel,
                          );
                        },
                        child: Text(
                          "WhatsApp",
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.appSecondoryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () async {
                          await checkProductExistence(uId: user!.uid);

                          Get.snackbar(
                            "Product added",
                            "",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        },
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //whatsapp message method
  static Future<void> sendMessageOnWhatsapp(
      {required ProductModel productModel}) async {
    final number = "+923355640044";
    final message =
        "Hello MysticMall \n i want to know about this product \n ${productModel.productName} \n ${productModel.productId}";
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

  //Check for product if its exist or not
  Future<void> checkProductExistence(
      {required String uId, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];

      //update quantity
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });

      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice));

      await documentReference.set(cartModel.toMap());
    }
  }
}
