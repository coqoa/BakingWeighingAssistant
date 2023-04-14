
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/enum.dart';

class RecipeController extends GetxController{

  Rx<RequestStatus> requestStatus = RequestStatus.EMPTY.obs;
  
  String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList recipeList = [].obs;
  RxList recipeIngredient = [].obs;
  RxList recipeWeight= [].obs;
  RxList recipeWeightTotal= [].obs;
  RxList multipleValue = [].obs;
  RxList divideWeight = [].obs;

  // * 레시피 로드
  loadRecipeList(menuTitle) async{
    requestStatus.value=RequestStatus.LOADING;
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').get().then((result){
      recipeList.value = result.data()!['RecipeList'];
    });
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').get().then((result) async{
      for(int i = 0; i<result.data()!.keys.length; i++){
        num sum = 0;
        recipeIngredient.add(result.data()![recipeList[i]]['ingredient']);
        recipeWeight.add(result.data()![recipeList[i]]['weight']);
        multipleValue.add(result.data()![recipeList[i]]['multipleValue']);
        divideWeight.add(result.data()![recipeList[i]]['divideWeight']);

        for(int j=0; j < (recipeWeight[i].length); j++ ){
          if(recipeWeight[i][j].length>0){
            sum+=double.parse(recipeWeight[i][j]);
          }
        }
        recipeWeightTotal.add(sum*multipleValue[i]);
      }
    });
    requestStatus.value=RequestStatus.SUCCESS;
  }

  // * 레시피 추가
  void createRecipe(
    String title, 
    String menuTitle, 
    List recipeListParam, 
    List ingredient, 
    List weight
  )async {
    if(title.isNotEmpty){
      // snackbar: 존재하는 타이틀
      if(recipeListParam.contains(title)){
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
          messageText: Center(child: Text("'$title' already exists")),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Palette.lightgray,
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }else{
        // 레시피 리스트에 추가 
        recipeListParam.add(title);
        // 레시피 리스트 Doc 업데이트생성
        await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').set(
          {'RecipeList':recipeListParam}
        );
        // 레시피 Doc 추가 
        await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
          {title:{'multipleValue': 1,'divideWeight': 1,'ingredient':ingredient,'weight':weight}}
        );
        Get.off(()=>Recipe(menuTitle: menuTitle));
      }
    }else{
      // snackbar: 타이틀을 입력해주세요
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
        messageText: Center(child: Text("Please enter a Title")),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        backgroundColor: Palette.lightgray,
        margin: EdgeInsets.only(bottom: 20.h),
        maxWidth: 300.w,
      );
    }
  }

  // * 레시피 수정

  void modifyRecipe(
    String title, 
    String originalTitle, 
    String menuTitle, 
    dynamic multipleValue, 
    dynamic divideWeight, 
    List recipeListParam, 
    List ingredient, 
    List weight
  )async {
    requestStatus.value=RequestStatus.LOADING;
    if(title.isNotEmpty){
      // originalTitle != title => 레시피 변경시 현재 타이틀을 다시 쓰기 위한 코드
      if(recipeListParam.contains(title) && originalTitle != title){
        // snackbar: 존재하는 타이틀
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
          messageText: Center(child: Text("'$title' already exists")),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Palette.lightgray,
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }else{
        // info: 레시피 리스트에 타이틀 변경
        recipeListParam[recipeListParam.indexOf(originalTitle)]=title;

        // info: RecipeList 업데이트
        await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').set(
          {'RecipeList':recipeListParam}
        );
        // info: original 데이터 제거
        await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update({
          originalTitle: FieldValue.delete(),
        });
        // info: new 데이터 입력
        await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
          {title:{'multipleValue': multipleValue, 'divideWeight': divideWeight, 'ingredient':ingredient,'weight':weight}}
        );
        Get.off(()=>Recipe(menuTitle: menuTitle,));
      }
    }else{
      // snackbar: 타이틀을 입력해주세요
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
        messageText: Center(child: Text("Please enter a Title")),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        backgroundColor: Palette.lightgray,
        margin: EdgeInsets.only(bottom: 20.h),
        maxWidth: 300.w,
      );
    }
    requestStatus.value=RequestStatus.SUCCESS;
  }

  // * 레시피 삭제
  deleteRecipe(menuTitle, index)async{
    // INFO: 기존 데이터 지우기
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update({
      recipeList[index]: FieldValue.delete(),
    });
    
    // INFO: 리스트 초기화
    recipeList.removeAt(index);
    recipeIngredient.removeAt(index);
    recipeWeight.removeAt(index);
    recipeWeightTotal.removeAt(index);
    multipleValue.removeAt(index);
    divideWeight.removeAt(index);

    // INFO: 변경된 레시피 리스트 업데이트
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').set(
      {'RecipeList':recipeList}
    );
  }
  // * 곱한 값 업데이트
  multipleValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    num sum = 0;
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue':double.parse(multipleIndicator),'divideWeight':divideWeight[index], 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    ).then((value){
      for(int j=0 ; j < (recipeWeight[index].length) ; j ++ ){
        if(recipeWeight[index][j].length>0){
          sum+=double.parse(recipeWeight[index][j]);
        }
      }
    });
    multipleValue[index] = double.parse(multipleIndicator); 
    recipeWeightTotal[index] = sum*multipleValue[index];
  }

  // * 나눈 값 업데이트
  divideValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue' : multipleValue[index], 'divideWeight':double.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    );
    divideWeight[index] = double.parse(multipleIndicator);
  }
}