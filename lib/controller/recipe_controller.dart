
import 'package:bwa/screen/recipe.dart';
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
    requestStatus.value=RequestStatus.SUCCESS;
  }
  deleteRecipe(menuTitle, index)async{
    // // original 데이터 제거
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update({
      recipeList[index]: FieldValue.delete(),
    });
    recipeList.removeAt(index);
    recipeIngredient.removeAt(index);
    recipeWeight.removeAt(index);

    // 레시피 리스트 Doc 업데이트생성
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').set(
      {'RecipeList':recipeList}
    );
    // // 

    // Get.off(()=>Recipe(menuTitle: menuTitle));
    
  }
  multipleValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue':int.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
      // {recipeTitle:{'multipleValue':double.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    );
    multipleValue[index] = int.parse(multipleIndicator);
    // multipleValue[index] = double.parse(multipleIndicator);
  }
}