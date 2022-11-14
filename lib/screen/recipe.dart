// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../config/enum.dart';


class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  
  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  var appStatus = RequestStatus.EMPTY.obs;

  late double boxHeight = MediaQuery.of(context).size.height;
  late double boxWidth = GetPlatform.isMobile? MediaQuery.of(context).size.width : 1000;
  
  late bool moreBtnFolded;

  // firebase Auth
  String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();
  // final _authentication = FirebaseAuth.instance;

  // Firestore
  List recipeList = [];
  List recipeDetailList = ['Touch Please'];
  List recipeKeyList = ['KEY'];
  List recipeValueList = ['VALUE'];
  // List values = []; // 삭제예정
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getRecipeList({required String email}) async {
    appStatus.value=RequestStatus.LOADING;
    await firestore.collection(email).doc('recipeList').get().then((value){
      value.data()?.keys.forEach((element) =>
        setState(() => 
          recipeList.add(element)
        )
      );
      // print('recipeList - $recipeList');
      // print('Auth Email : ${currentUserEmail} - recipe.dart 50 line');
    });
    appStatus.value=RequestStatus.SUCCESS;
  }

  Future<void> getRecipeDetail({required String email, required String title})async {
    appStatus.value=RequestStatus.LOADING;
    try{
      CollectionReference<Map<String, dynamic>> test = firestore.collection(email).doc('recipe').collection(title);
      await test.get().then((value){
        int docLength = value.docs.length; // doc갯수
        bool notEmptyList = value.docs.isNotEmpty; // 빈 리스트인지 확인
        // 예외처리
        if(notEmptyList){
          recipeKeyList.clear();
          recipeValueList.clear();
          for(int i=0; i<docLength; i++){
            test.doc('$i').get().then((value) {
              setState(() {
                recipeKeyList.add(value.data()?.keys.first);
                recipeValueList.add(value.data()?.values.first);
              }); // 여기 불필요한 () 제거 해결
            });
          }
        }else{
          setState(() => recipeKeyList.clear());
        }
        
      });
    }catch(e){
      print('ERROR = $e');
    }
    appStatus.value=RequestStatus.SUCCESS;
  }

  @override
  void initState() {
    moreBtnFolded = true;
    super.initState();
    
    getRecipeList(
      email: currentUserEmail
    );
    // getRecipeList 이후에 실행되게 하려면?
    getRecipeDetail(
      email: currentUserEmail,
      title: 'recipeList[0]'
    );
  }

  @override
  Widget build(BuildContext context) {
    return appStatus.value != RequestStatus.SUCCESS 
    ? SizedBox()
    : KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) { 
        return Scaffold(
          backgroundColor: Palette.lightyellow,
          body: Center(
            child: Column(
              children: [
              // 로고
              // !isKeyboardVisible?
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Baking Weighing Assistant',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'carter',
                        fontSize: GetPlatform.isMobile ? 20 : 35
                      ),
                    ),
                ),
              ),
              // 내용
              Expanded(
                flex: 10,
                child: Container(
                  height: GetPlatform.isMobile? boxHeight*0.67 : 450,
                  width: boxWidth,
                  padding: EdgeInsets.fromLTRB(10,0,10,10),
                  
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 리스트
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.bounceOut,
                          // width: listFolded ? boxWidth*0.1 : boxWidth*0.3,
                          width: GetPlatform.isMobile? boxWidth*0.3 : 200,
                          decoration: BoxDecoration(
                            color: Palette.lightyellow,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 20,
                                height: 20,
                              ),
                              // !listFolded 
                              // ? 
                              Expanded(

                                // 리스트
                                child: Column(
                                  // ignore: prefer_co
                                  //nst_literals_to_create_immutables
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: recipeList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => {
                                            getRecipeDetail(
                                              email: currentUserEmail,
                                              title: recipeList[index]
                                            ),
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colors.amber,
                                            child: Center(
                                              child: Text(recipeList[index])
                                            ),
                                          ),
                                        );
                                      }
                                    )
                                    // TextField(),
                                    // Text(recipeList.length.toString(), style: TextStyle(fontSize: 20),),
                                    // Text(recipeList[0], style: TextStyle(fontSize: 20),),
                                    // Text(recipeList[1], style: TextStyle(fontSize: 20),),
                                    // Text(recipeList[2], style: TextStyle(fontSize: 20),),
                                  ],
                                ),
                              )
                              // : SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                      // 레시피
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.lightyellow,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: recipeKeyList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return 
                                            appStatus.value != RequestStatus.SUCCESS 
                                            ? SizedBox()
                                            :
                                            GestureDetector(
                                              child: Container(
                                                width: 150,
                                                height: 50,
                                                // child: Text(recipeDetailList[index].toString()),
                                                child: Row(
                                                  children: [
                                                    Text(recipeKeyList[index].toString()),
                                                    Text(recipeValueList[index].toString()),
                                                    // Text(recipeDetailList[index].keys.toString()),
                                                    // Text(recipeDetailList[index].values.toString()),
                                                  ],
                                                )
                                                // 여기 : () 없애기 // replace?? 
                                              )
                                            );
                                        }
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                AnimatedPositioned(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.bounceOut,
                                    bottom: moreBtnFolded ? 0 : 90,
                                    right: 5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Palette.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        fixedSize: Size(70, 35),
                                        padding: const EdgeInsets.all(0),
                                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        elevation: 0,
                                        shadowColor: Colors.transparent
                                      ),
                                      child: Text('Add',
                                        style: TextStyle(
                                          fontFamily: 'carter',
                                          fontSize: 16,
                                          color: Palette.white
                                        ),
                                      ),
                                      onPressed: (){
                                        print('ADD');
                                      },
                                    ),
                                  ),
                                  AnimatedPositioned(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.bounceOut,
                                    bottom: moreBtnFolded ? 0 : 45,
                                    
                                    right: 5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Palette.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        fixedSize: Size(70, 35),
                                        padding: const EdgeInsets.all(0),
                                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        elevation: 0,
                                        shadowColor: Colors.transparent
                                      ),
                                      child: Text('Update',
                                        style: TextStyle(
                                          fontFamily: 'carter',
                                          fontSize: 15,
                                          color: Palette.white
                                        ),
                                      ),
                                      onPressed: (){
                                        print('Update');
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Palette.middleblack,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        fixedSize: Size(70, 35),
                                        padding: const EdgeInsets.all(0),
                                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        elevation: 0,
                                        shadowColor: Colors.transparent
                                      ),
                                      child: Text(moreBtnFolded?'▲':'▼',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Palette.white
                                        ),
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          moreBtnFolded = !moreBtnFolded;
                                        });
                                      },
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
            ]),
          ),
        );
      },
    );
  }
}

