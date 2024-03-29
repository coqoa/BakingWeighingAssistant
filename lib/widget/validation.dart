import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/palette.dart';

class Validation{

  validationSnackBar(errorCode){
    return  Get.snackbar(
      "","",
      titleText: Center(
        child: Text("error".tr, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white
          )
        )
      ),
      messageText: Center(
        child: Text('$errorCode',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(milliseconds: 3000),
      forwardAnimationCurve: Curves.easeInOutQuart,
      reverseAnimationCurve: Curves.easeInQuart,
      backgroundColor: Palette.black.withOpacity(0.5),
      margin: EdgeInsets.only(bottom: 20),
      maxWidth: 300,
    );
  }
}