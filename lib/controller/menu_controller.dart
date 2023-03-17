import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../screen/recipe.dart';

class MenuController extends GetxController{

  RxList menuList = [].obs;
  Rx<RequestStatus> requestStatus = RequestStatus.EMPTY.obs;
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // * 메뉴 로드
  loadMenuList()async{
    requestStatus.value=RequestStatus.LOADING;
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).get().then((result){
      menuList.value = result.data()!['menuList'];
    });
    requestStatus.value=RequestStatus.SUCCESS;
  }

  // * 메뉴 -> 레시피 이동
  moveToMenuDetails(menuTitle){
    Get.to(()=>Recipe(menuTitle: menuTitle,));
  }

  // * 메뉴 추가
  addMenu(e)async{
    if(e.length > 0){
      if(!menuList.contains(e)){
        // info: 메뉴리스트에 추가
        menuList.add(e);
        // info: 메뉴리스트 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});
        // info: 메모 생성 
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Memo').set({"Memo":''});
        // info: 레시피 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('Recipe').set({});
        // info: 레시피 리스트 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).collection(e).doc('RecipeList').set({"RecipeList":[]});

      }else{
        // Snackbar: 존재하는 타이틀일 경우 처리
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
              "'An already Existing Title"
            )
          ),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Palette.lightgray,
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }
    }else{
      // Snackbar: title이 공백일 경우 처리
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
            "Please check the Title"
          )
        ),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        backgroundColor: Palette.lightgray,
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
    // info: firebase는 내부에 있는 모든 doc을 지워줘야 collection을 지울 수 있음
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
        messageText: const Center(child: Text("Please check the Title")),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        backgroundColor: Palette.lightgray,
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
          messageText: Center(child: Text("'$changedTitle' is already exists Title")),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Palette.lightgray,
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }
    }
  }

  dragAndDropMenu()async{
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({'menuList':menuList});
  }

  loading(){
    requestStatus.value=RequestStatus.LOADING;
  }

  sucess(){
    requestStatus.value=RequestStatus.SUCCESS;
  }
}