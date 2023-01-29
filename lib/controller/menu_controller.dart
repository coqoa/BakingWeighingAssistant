import 'package:bwa/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../screen/recipe.dart';

class MenuController extends GetxController{

  RxList menuList = [].obs;
  
  String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  loadMenuList()async{
    // var result = firestore.collection('admin@admin.com').doc('MenuList').collection('Menu').doc('Recipe');
    // await result.get().then((value){
    //   print(value.data());
    // });
    // 레시피 페이지 에서 필요한 데이터
    await firestore.collection('users').doc(email).get().then((result){
      menuList.value = result.data()!['menuList'];
    });
  }

  moveToMenuDetails(menuTitle){
    Get.to(()=>Recipe(menuTitle: menuTitle,));
  }

  // 리스트 db로 전송하는 메소드 만들고 드래그이벤트 발생시 해당 메소드 호출하도록
  // TODO 존재하는 title이라면 사용하지 못하도록 막아야함
  addMenu(e)async{
    // print(menuList);
    menuList.add(e);
    // print(e);
    // print(menuList);
    await firestore.collection('users').doc(email).set({'menuList':menuList});
  }
  deleteMenu(e)async{
    // print(e);
    // print(menuList.indexOf(e));
    menuList.remove(e);
    await firestore.collection('users').doc(email).set({'menuList':menuList});
  }
  editMenu(title, changedTitle)async{
    if(changedTitle.length<1 || title == changedTitle){
      Get.snackbar(
        "","",
        titleText: const Center(
          child: Text("ERROR", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            )
          )
        ),
        messageText: const Center(child: Text("'TITLE'을 확인해주세요.")),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        // duration: Duration(milliseconds: 1000),
        backgroundColor: Palette.lightgray,
        // messageText: "'TITLE'을 확인해주세요"
        margin: EdgeInsets.only(bottom: 20.h),
        maxWidth: 200.w,
      );
    }else{
      if(!menuList.contains(changedTitle)){
        menuList[menuList.indexOf(title)]=changedTitle;
        await firestore.collection('users').doc(email).set({'menuList':menuList});
      }else{
        Get.snackbar(
          "","",
          titleText: const Center(
            child: Text("ERROR", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              )
            )
          ),
          messageText: Center(child: Text("'$changedTitle'은(는) 존재하는 'Title'입니다.")),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          // duration: Duration(milliseconds: 1000),
          backgroundColor: Palette.lightgray,
          // messageText: "'TITLE'을 확인해주세요"
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }
    }
  }
  dragAndDropMenu()async{
    await firestore.collection('users').doc(email).set({'menuList':menuList});
  }
  


}