// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mystic_mall/utils/app_constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText; 

  const HeadingWidget({
    super.key,
    required this.headingTitle,
    required this.headingSubTitle,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                  Text(
                  headingSubTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ), 
            GestureDetector(
              onTap: onTap,
              child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: AppConstant.appSecondoryColor,
                  width: 1.5,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(buttonText, style: const TextStyle(
                  fontWeight: FontWeight.w500, 
                  fontSize: 12.0,
                  color: AppConstant.appSecondoryColor
                ),),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
