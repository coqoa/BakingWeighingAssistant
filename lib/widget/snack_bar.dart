
import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSnackBar{
  snackBar(
    String titleText,
    String messageText
  ){
    return Get.snackbar(
      "","",
      titleText: Center(
        child: Text(titleText, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          )
        )
      ),
      messageText: Center(child: Text(messageText)),
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.elasticIn,
      reverseAnimationCurve: Curves.easeOut,
      backgroundColor: Palette.lightgray,
      margin: EdgeInsets.only(bottom: 20.h),
      maxWidth: 300.w,
    );
  }
}