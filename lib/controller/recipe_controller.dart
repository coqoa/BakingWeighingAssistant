
// ignore_for_file: invalid_use_of_protected_member

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

  loadRecipeList(menuTitle) async{
    requestStatus.value=RequestStatus.LOADING;
    await firestore.collection('users').doc(email).collection(menuTitle).doc('RecipeList').get().then((result){
      recipeList.value = result.data()!['RecipeList'];
    }
    );
    await firestore.collection('users').doc(email).collection(menuTitle).doc('Recipe').get().then((result) async{
      for(int i = 0; i<result.data()!.keys.length; i++){
        // print(result.data()![recipeList[i]]['ingredient']);
        // print(result.data()![recipeList[i]]['weight']);
        
        // recipeIngredient[i]= await result.data()![recipeList[i]]['ingredient'];
        // recipeIngredient.value.add([]);
        // recipeWeight[i] = await result.data()![recipeList[i]]['weight'];
        // recipeWeight.value.add([]);
        recipeIngredient.add(result.data()![recipeList[i]]['ingredient']);
        recipeWeight.add(result.data()![recipeList[i]]['weight']);
        // TODO RXLIST에 값을 추가하려면 어떻게 해야함? 
        // TODO RXLIST가 아니라 List로 관리하고, 쓰는 쪽에서 인덱스를 조건으로?
      }
      // recipeIngredient[index] = result.data()![recipeList[index]]['ingredient'];
      // recipeWeight[index] = result.data()![recipeList[index]]['weight'];

      // print(result.data()!.keys.length);
      // print(recipeList.length);
    });
    print('asdasdasdasdasdasdasdasd');
    requestStatus.value=RequestStatus.SUCCESS;
  }
}