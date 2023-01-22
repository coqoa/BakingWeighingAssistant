
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../config/enum.dart';

class RecipeController extends GetxController{

  String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // var appStatus = RequestStatus.EMPTY.obs;

  // RxList recipeList = [].obs;
  // RxList recipeDetailList = ['Touch Please'].obs;
  // RxList recipeKeyList = ['KEYS'].obs;
  // RxList recipeValueList = ['VALUES'].obs;

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<void> getRecipeList({required String email}) async {
  //   appStatus.value=RequestStatus.LOADING;
  //   await firestore.collection(email).doc('recipeList').get().then((value){
  //     value.data()?.keys.forEach((element) => 
  //         // ignore: invalid_use_of_protected_member
  //         recipeList.value.add(element)
  //     );
  //   });
  //   appStatus.value=RequestStatus.SUCCESS;
  // }

  // Future<void> getRecipeDetail({required String email, required String title})async {
  //   // title을 인자로 받아야하나?
  //   appStatus.value=RequestStatus.LOADING;
  //   try{
  //     CollectionReference<Map<String, dynamic>> test = firestore.collection(email).doc('recipe').collection(title);
  //     await test.get().then((value){
  //       int docLength = value.docs.length; // doc갯수
  //       bool notEmptyList = value.docs.isNotEmpty; // 빈 리스트인지 확인
  //       // 예외처리
  //       if(notEmptyList){
  //         recipeKeyList.clear();
  //         recipeValueList.clear();
  //         for(int i=0; i<docLength; i++){
  //           test.doc('$i').get().then((value) {
  //               recipeKeyList.value.add(value.data()?.keys.first);
  //               recipeValueList.value.add(value.data()?.values.first);
  //           });
  //         }
  //       }else{
  //         recipeKeyList.value.clear();
  //       }
        
  //     });
  //   }catch(e){
  //     print('ERROR = $e');
  //   }
  //   appStatus.value=RequestStatus.SUCCESS;
  // }
  RxList recipeList = [].obs;
  RxInt testListSelected = 0.obs;

  // RxList testRecipeDetail = ['test1', 'test2', 'test3', 'test4', 'test5', 'test6', 'test7', 'test8', 'test9'].obs;

  loadRecipeList(menuTitle) async{
    // await firestore.collection(email!).doc('MenuList').collection(menuTitle).doc('Recipe').get().then((result){
    await firestore.collection('users').doc(email).get().then((result){
      print('Recipe Controllerrrrrrrrrr');
      print(menuTitle); // TODO : 여기까지완료
      recipeList.value = result.data()![menuTitle]['List']; // 리스트
      // print('여기부터');
      // print(recipeList[1]); 
      // // 레시피 타이틀
      // print(result.data()![menuTitle][recipeList[1]]['Ingredient']); 
      // // [비가 반죽, 강력분, 물, 생 이스트, 최종 반죽, 강력분, 물, 소금, 이스트, 비가 반죽]
      // print(result.data()![menuTitle][recipeList[1]]['Weight']); 
      // // [, 2000, 1200, 4, , 8000, 6100, 200, 116, 3204]
      // // TODO : 그려가면서 데이터 빼 올 작어 ㅂ하기
      print(recipeList);
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