

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// import '../config/enum.dart';

// class RecipeController extends GetxController {

//   var appStatus = RequestStatus.EMPTY.obs;

//   // firebase Auth
//   final _authentication = FirebaseAuth.instance;
//   String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

//   // Firestore
//   RxList recipeList = [].obs;
//   List values = []; // 삭제예정

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<void> getRecipeList({required String email}) async {

//     appStatus.value=RequestStatus.LOADING;

//     await firestore.collection(email).doc('recipeList').get().then((value){
//       value.data()?.keys.forEach((element) {
//           recipeList.add(element);
//       });
//       // value.data()?.keys.forEach((element) {keys.add(element);}); // 삭제예정
//       print('recipeList - $recipeList');
//       print('Auth Email : ${currentUserEmail} - recipe.dart 50 line');
//     });
//     appStatus.value=RequestStatus.SUCCESS;
//   }
// }