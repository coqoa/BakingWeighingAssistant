
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../config/enum.dart';

class RecipeController extends GetxController{

  Rx<RequestStatus> requestStatus = RequestStatus.EMPTY.obs;
  
  String? email = FirebaseAuth.instance.currentUser?.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList recipeList = [].obs;
  RxList recipeIngredient = [].obs;
  RxList recipeWeight= [].obs;
  RxInt testListSelected = 0.obs;
  RxList multipleValue = [].obs;

  loadRecipeList(menuTitle) async{
    requestStatus.value=RequestStatus.LOADING;
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').get().then((result){
      recipeList.value = result.data()!['RecipeList'];
    }
    );
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').get().then((result) async{
      for(int i = 0; i<result.data()!.keys.length; i++){
        recipeIngredient.add(result.data()![recipeList[i]]['ingredient']);
        recipeWeight.add(result.data()![recipeList[i]]['weight']);
        multipleValue.add(result.data()![recipeList[i]]['multipleValue']);
      }
    });
    // print('recipeIngredient = $recipeIngredient');
    // print('recipeWeight = $recipeWeight');
    // print('multipleValue = $multipleValue');
    requestStatus.value=RequestStatus.SUCCESS;
  }
  deleteRecipe(menuTitle, index)async{
    // original 데이터 제거
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update({
      recipeList[index]: FieldValue.delete(),
    });
    // print('DELETERECIPE');
    // print(recipeList);
    // print(menuTitle);
    // print(recipeTitle);
    // print('DELETERECIPE');

    // print(index);
    // print('1----');
    // print(recipeList);
    recipeList.removeAt(index);
    // print(recipeList);

    // 레시피 리스트 Doc 업데이트생성
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').set(
      {'RecipeList':recipeList}
    );
    
  }
  multipleValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    // print('aaa!');
    // print(menuTitle);
    // print(recipeTitle);
    // print(index);
    // print('recipeIngredient = ${recipeIngredient[index]}');
    // print('recipeWeight = ${recipeWeight[index]}');
    // print(multipleIndicator);
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue':int.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    );
    multipleValue[index] = int.parse(multipleIndicator);
  }
}