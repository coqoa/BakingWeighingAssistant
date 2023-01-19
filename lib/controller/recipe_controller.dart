
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../config/enum.dart';

class RecipeController extends GetxController{
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
  RxList testList = ['단팥빵', '소보로빵', '슈크림빵', '맘모스', '소라빵', '베이글', '파운드케이크', '바게트', '건강빵'].obs;
  RxInt testListSelected = 0.obs;

  RxList testRecipeDetail = ['강력분', '밀가루', '물', '우유', '버터', '계란', '설탕', '소금', '이스트'].obs;

  loadRecipeList(recipeList){
    print('Recipe Controllerrrrrrrrrr');
    print(recipeList);
  }


  
}