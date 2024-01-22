import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:mystic_mall/controllers/cart_price_controller.dart';
import 'package:mystic_mall/controllers/get_cutomer_device_token_controller.dart';
import 'package:mystic_mall/services/place_order_services.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constant.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppConstant.appTextColor,
        backgroundColor: AppConstant.appMainColor,
        title: const Text('Checkout Screen'),
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
                          showCustomBottomSheet();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Confirm Order",
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

  void showCustomBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: nameController,
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                const SizedBox(height: 20.0),
                _buildTextField(
                  controller: phoneController,
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20.0),
                _buildTextField(
                  controller: addressController,
                  labelText: 'Address',
                  hintText: 'Enter your address',
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        addressController.text.isNotEmpty) {
                      String name = nameController.text.trim();
                      String phone = phoneController.text.trim();
                      String address = addressController.text.trim();
                      String customerToken = await getCustomerDeviceToken();

                      // Place order service
                      // ignore: use_build_context_synchronously
                      placeOrder(
                        context: context,
                        customerName: name,
                        customerPhone: phone,
                        customerAddress: address,
                        customerDeviceToken: customerToken,
                      );
                    } else {
                      // ignore: avoid_print
                      print("Please fill all details");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appMainColor,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 55.9,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          hintStyle: const TextStyle(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
