import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      menuList.value = result.data()!['FolderList'];
    });
  }

  moveToMenuDetails(menuTitle){
    Get.to(Recipe(menuTitle: menuTitle,));
  }

  // 리스트 db로 전송하는 메소드 만들고 드래그이벤트 발생시 해당 메소드 호출하도록


}