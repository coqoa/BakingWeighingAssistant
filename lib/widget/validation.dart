import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/palette.dart';

class Validation{

  validationSnackBar(errorCode){
    return  Get.snackbar(
        "","",
        titleText: const Center(
          child: Text("Error", 
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
        duration: Duration(milliseconds: 2500),
        forwardAnimationCurve: Curves.easeInOutQuart,
        reverseAnimationCurve: Curves.easeInQuart,
        backgroundColor: Palette.black.withOpacity(0.5),
        margin: EdgeInsets.only(bottom: 20),
        maxWidth: 300,
      );
}

}