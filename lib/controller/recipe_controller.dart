
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../config/enum.dart';

class RecipeController extends GetxController{

  String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList recipeList = [].obs;
  RxInt testListSelected = 0.obs;

  loadRecipeList(menuTitle) async{
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').get().then((result){
      recipeList.value = result.data()!['RecipeList'];
    }
    );
  }
  // TODO : 상세 레시피는 아래 메소드 구현해서 출력하기
  // loadRecipeDetails(menuTitle) async{
  //   await firestore.collection(email!).doc('MenuList').collection(menuTitle).doc('Recipe').get().then((result){
  //     print('Recipe Controllerrrrrrrrrr');
  //     print(result.data()); //{단팥빵: [{중량: 1000, 재료: 밀가루}, {중량: 200, 재료: 계란}]}
  //   });
  //   // print(e);
  // }


  
}