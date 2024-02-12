// ignore: implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mystic_mall/models/order_model.dart';
import 'package:mystic_mall/screens/user-panel/main_screen.dart';
import 'package:mystic_mall/services/generate_order_id_service.dart';
import 'package:mystic_mall/utils/app_constant.dart';

void placeOrder(
    {required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String customerDeviceToken}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "please Wait..");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        //unique order id genereted
        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
          productId: data['productId'],
          categoryId: data['categoryId'],
          productName: data['productName'],
          categoryName: data['categoryName'],
          salePrice: data['salePrice'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          isSale: data['isSale'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            'uId': user.uid,
            'customerName': customerName,
            'customerPhone': customerPhone,
            'customerAddress': customerAddress,
            'customerDeviceToken': customerDeviceToken,
            'orderStatus': false,
            'createdAt': DateTime.now()
          });

          //upload orders

          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          //delete cart product -means when order is created we will delet those prodcut from cart

          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId.toString())
              .delete();
        }
        // ignore: avoid_print
        print('Order Confired');
        Get.snackbar('Order Confirmed', 'Thankyou for your order!',
        backgroundColor: AppConstant.appMainColor, 
        colorText: AppConstant.appTextColor, 
        duration: const Duration(seconds: 5),
        );
        EasyLoading.dismiss();
        Get.offAll(const MainScreen());
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error $e");
    }
  }
}
