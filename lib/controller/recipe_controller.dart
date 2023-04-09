
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // * 레시피 삭제
  deleteRecipe(menuTitle, index)async{
    // 기존 데이터 지우기
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update({
      recipeList[index]: FieldValue.delete(),
    });
    
    // 리스트 초기화
    recipeList.removeAt(index);
    recipeIngredient.removeAt(index);
    recipeWeight.removeAt(index);
    recipeWeightTotal.removeAt(index);
    multipleValue.removeAt(index);
    divideWeight.removeAt(index);

    // 변경된 레시피 리스트 업데이트
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