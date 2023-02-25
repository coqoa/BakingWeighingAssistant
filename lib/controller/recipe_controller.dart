
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
  RxList recipeWeightTotal= [].obs;
  RxInt testListSelected = 0.obs;
  RxList multipleValue = [].obs;
  RxList divideValue = [].obs;

  loadRecipeList(menuTitle) async{
    requestStatus.value=RequestStatus.LOADING;
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').get().then((result){
      recipeList.value = result.data()!['RecipeList'];
    }
    );
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').get().then((result) async{
      for(int i = 0; i<result.data()!.keys.length; i++){
        num sum = 0;
        recipeIngredient.add(result.data()![recipeList[i]]['ingredient']);
        recipeWeight.add(result.data()![recipeList[i]]['weight']);
        multipleValue.add(result.data()![recipeList[i]]['multipleValue']);
        divideValue.add(result.data()![recipeList[i]]['divideWeight']);

        for(int j=0; j < (recipeWeight[i].length); j++ ){
            sum+=j;
        // print(sum);
        }
        // print('x');
        // print(multipleValue[i]);
        // print('===');
        recipeWeightTotal.add(sum);
        
        
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

    // Get.off(()=>Recipe(menuTitle: menuTitle));
    
  }

  // HERE: 여기부터하자 아이고머리아프다
  multipleValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    num sum = 0;

    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue':int.parse(multipleIndicator),'divideWeight':divideValue[index], 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
      // {recipeTitle:{'multipleValue':double.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    );

    // for(int j=0 ; j < (recipeWeight[index].length) ; j ++ ){
    //     // sum += int.parse(recipeWeight[index][j]) ;
    //     sum += j;
    //     print(sum);
    // }
    // print('==');

    multipleValue[index] = int.parse(multipleIndicator);
    recipeWeightTotal[index] = sum*multipleValue[index];
  }
  divideValueUpdate(menuTitle, recipeTitle, index, multipleIndicator)async{
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').update(
      {recipeTitle:{'multipleValue' : multipleValue[index], 'divideWeight':int.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
      // {recipeTitle:{'multipleValue':double.parse(multipleIndicator), 'ingredient':recipeIngredient[index], 'weight':recipeWeight[index]}}
    );
    divideValue[index] = int.parse(multipleIndicator);
    // multipleValue[index] = double.parse(multipleIndicator);
  }
}