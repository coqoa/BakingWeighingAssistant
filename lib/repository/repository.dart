import 'package:cloud_firestore/cloud_firestore.dart';

class Repository{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getRecipeList()async {
    List t = [];
    await firestore
      .collection('web@admin.com')
      .doc('recipeList')
      .get()
      .then((value) => 
        t.add(value.data())
      );
      print(t); // [{단팥빵: 단팥빵, 슈크림빵: 슈크림빵, 카스테라: 카스테라}]
      // 키값만 배열에 넣고싶은데 어떻게 ? map함수? 
    
  }

  Future<void> getRecipe()async {

  }
}