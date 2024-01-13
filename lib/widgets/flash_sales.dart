// ignore_for_file: avoid_unnecessary_containers

import "package:cached_network_image/cached_network_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:get/get.dart";
import "package:image_card/image_card.dart";
import "package:mystic_mall/models/products_model.dart";
import "package:mystic_mall/utils/app_constant.dart";

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: true)
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No products found!'),
          );
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height / 4.5,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  ProductModel productModel = ProductModel(
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
                  );

                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 3.5,
                            heightImage: Get.height / 20,
                            imageProvider: CachedNetworkImageProvider(
                              //at start we will shwo only one image but when user click see more all sales will be visiuble
                              productModel.productImages[0],
                            ),
                            title: Center(
                                child: Text(
                              productModel.productName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10.0),
                            )),
                            footer: Row(
                              children: [
                                Text(
                                  ' ${productModel.salePrice}',
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                                const SizedBox(
                                  width: 2.0,
                                ),
                                Text(
                                  'Rs ${productModel.fullPrice}',
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      color: AppConstant.appSecondoryColor,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          );
        }
        return Container();
      },
    );
  }
}
