import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/palette.dart';

class MainController{

  translate(){
    if(Get.locale == Locale('en', 'US')){
      Get.updateLocale(const Locale('ko', 'KR'));
    }else{
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
  mainController(){
    return GestureDetector(
      onTap: (){
        translate();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1.5, color: Colors.black)
        ),
        child: Center(
          child: Text(Get.locale == Locale('en', 'US') ? 'ENG' : 'KOR',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14
            ),
          )
        ),
      ),
    );
  }
}