import 'package:bwa/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../screen/recipe.dart';

class MenuController extends GetxController{

  RxList menuList = [].obs;
  
  // String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // var emailPath = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email);

  loadMenuList()async{
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).get().then((result){
      menuList.value = result.data()!['menuList'];
    });
  }

  moveToMenuDetails(menuTitle){
    Get.to(()=>Recipe(menuTitle: menuTitle,));
  }

  addMenu(e)async{
    // var addAllDoc = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e);

    if(e.length > 0){
      if(!menuList.contains(e)){
        // 메뉴리스트에 추가
        menuList.add(e);
        // menuList doc 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});
        // 메모추가 
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Memo').set({"Memo":''});
        // 레시피추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Recipe').set({});
        // 레시피 리스트 추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('RecipeList').set({"RecipeList":[]});

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
          messageText: const Center(
            child: Text(
              "'TITLE'을 확인해주세요."
            )
          ),
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
        messageText: const Center(
          child: Text(
            "'TITLE'을 확인해주세요."
          )
        ),
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

  deleteMenu(e)async{

    menuList.remove(e);
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Memo').delete();
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Recipe').delete();
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('RecipeList').delete();
    // 내부에 있는 모든 doc을 지워주면 collection을 지워줌
  }

  editMenu(originalTitle, changedTitle)async{
    if(changedTitle.length<1 || originalTitle == changedTitle){
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
        
        var originalMemo = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('Memo').get();
        var originalRecipe = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('Recipe').get();
        var originalRecipeList = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('RecipeList').get();

        // 리스트 변경 후 업데이트
        menuList[menuList.indexOf(originalTitle)]=changedTitle;
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});

        // await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('Recipe').get().then((value){
        //   print(value.data().runtimeType);
        //   // Map<String, dynamic> test = {'가나다':{'미미미':123}};
        //   Map<String, dynamic>? test = value.data();
        //   print(test.runtimeType);
        //   firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(changedTitle).doc('Recipe').set(value.data()!);
        // });

        // 변경 레시피 : 메모 추가 
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(changedTitle).doc('Memo').set(originalMemo.data()!);
        // 변경 레시피 : 레시피 추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(changedTitle).doc('Recipe').set(originalRecipe.data()!);
        // 변경 레시피 : 레시피 리스트 추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(changedTitle).doc('RecipeList').set(originalRecipeList.data()!);

        // 기존데이터 삭제해주기

        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('Memo').delete();
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('Recipe').delete();
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(originalTitle).doc('RecipeList').delete();
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
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});
  }
}