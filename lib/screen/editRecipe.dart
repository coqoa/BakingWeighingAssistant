// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({super.key, required this.menuTitle, required this.recipeTitle});

  final String menuTitle;
  final String recipeTitle;

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email = FirebaseAuth.instance.currentUser?.email;

  String title = '';
  List ingredient = [];
  List weight = [];
  late dynamic recipeList = [];

  late TextEditingController _controller;
  
  void modifyRecipe()async {
    print('Modify!!!!!');
    // if(title.isNotEmpty){
    //   // ALERT : 존재하는 타이틀
    //   if(recipeList.contains(title)){
    //     Get.snackbar(
    //       "","",
    //       titleText: const Center(
    //         child: Text("ERROR", 
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 15
    //           )
    //         )
    //       ),
    //       messageText: Center(child: Text("'$title'은(는) 이미 존재합니다.")),
    //       snackPosition: SnackPosition.BOTTOM,
    //       forwardAnimationCurve: Curves.elasticIn,
    //       reverseAnimationCurve: Curves.easeOut,
    //       backgroundColor: Palette.lightgray,
    //       margin: EdgeInsets.only(bottom: 20.h),
    //       maxWidth: 300.w,
    //     );
    //   }else{
    //     // 레시피 리스트에 추가 
    //     await recipeList.add(title);
    //     // 레시피 리스트 Doc 업데이트생성
    //     await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('RecipeList').set(
    //       {'RecipeList':recipeList}
    //     );
    //     // 레시피 Doc 추가 // 중복안됨
    //     await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').update(
    //       {title:{'ingredient':ingredient,'weight':weight}}
    //     );
    //     Get.offAll(()=>Recipe(menuTitle: widget.menuTitle));
    //   }
    // }else{
    //   // ALERT  타이틀을 입력해주세요
    //   Get.snackbar(
    //     "","",
    //     titleText: const Center(
    //       child: Text("ERROR", 
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 15
    //         )
    //       )
    //     ),
    //     messageText: Center(child: Text("TITLE을 채워주세용")),
    //     snackPosition: SnackPosition.BOTTOM,
    //     forwardAnimationCurve: Curves.elasticIn,
    //     reverseAnimationCurve: Curves.easeOut,
    //     backgroundColor: Palette.lightgray,
    //     margin: EdgeInsets.only(bottom: 20.h),
    //     maxWidth: 300.w,
    //   );
    // }
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _controller = new TextEditingController(text: widget.recipeTitle);

    firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').get().then((value){
      // print(value.data()![widget.recipeTitle]);
      // print(value[widget.recipeTitle]);
      setState(() {
        ingredient = value[widget.recipeTitle]['ingredient'];
        weight = value[widget.recipeTitle]['weight'];
        // ingredient.add('');
        // weight.add('');
      });
      print(ingredient);
      print(weight);
      // setState(() {
      //   recipeList = value.data()!['RecipeList'];
      // });
    });
    // print(widget.menuTitle);
    // print(widget.recipeTitle);
    // print(recipeList);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 2,
        leading:  GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            width: 50,
            height: 50,
            color: Palette.white,
            child: const Center(
              child: Text('<',
                style: TextStyle(
                  fontSize: 18,
                  color: Palette.darkgray
                ),
              )
            ),
          ),
        ),
        title: const Text('Edit',
          style: TextStyle(
            color: Palette.darkgray
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              modifyRecipe();
            },
            child: Container(
              width: 50,
              height: 50,
              color: Palette.white,
              child: Center(
                child: ((){
                  if(ingredient.isEmpty || weight.isEmpty || title.isEmpty){
                    return const Text('완료',
                      style: TextStyle(
                        color: Palette.gray
                      ),
                    );
                  }else{
                    return const Text('완료',
                      style: TextStyle(
                        color: Palette.black,
                        fontWeight: FontWeight.bold
                      ),
                    );
                  }
                }())
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Align( 
          alignment: Alignment.topCenter,
          child: Container(
            height: 580.h,
            // color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // 타이틀 
                Container(
                  width: 330.w,
                  margin: EdgeInsets.only(top: 10.h),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _controller,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 25
                    ),
                    onChanged: (value) => title = value,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.transparent),
                      ),
                      hintText: "Title"
                    ),
                  ),
                ),
                // 시트 헤더
                Container(
                  width: 330.w,
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    border: Border(bottom: BorderSide(width: 1, color: Palette.lightgray))
                  ),
                  // margin: EdgeInsets.only(bottom: 4),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 165.w,
                        height: 60.h,
                        child: const Center(child: Text('재료명',
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ))
                      ),
                      SizedBox(
                        width: 165.w,
                        height: 50.h,
                        child: const Center(child: Text('중량',
                          style: TextStyle(
                            fontSize: 15
                          ),                        
                        ))
                      ),
                    ]
                  ),
                ),
      
                // 시트 바디
                Container(
                  width: 330.w,
                  height: 305.h,
                  color: Colors.blue,
                  child: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) { 
                      // setState(() {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveIngredient = ingredient.removeAt(oldIndex);
                        final moveWeight = weight.removeAt(oldIndex);
                        ingredient.insert(newIndex, moveIngredient);
                        weight.insert(newIndex, moveWeight);
                        
                      });
                      //   // print(controller.menuList);
                        // controller.dragAndDropMenu(); // db업데이트 
                        
                      // });

                     },
                    children: List.generate(ingredient.length, (item)=>Container(
                        key: Key('${ingredient[item]}$item}${weight[item]}'),
                        // child: Text('$item : ${ingredient[item]}, ${weight[item]}'),
                        child: Row(
                          children: [
                            Text('$item 위아래'),
                            Container(
                              width: 100,
                              child: TextFormField(
                                initialValue: ingredient[item],
                                onChanged: (value){
                                  setState(() {
                                    print(item);
                                    print(ingredient);
                                    print(ingredient[item]);
                                    print(value);
                                    ingredient.add('');
                                    
                                    // if(ingredient.length <= item){
                                        // ingredient.add("");
                                        // weight.add("");
                                      // }
                                    // ingredient[item] = value;
                                    
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      )),
                    // children: [
                    //   ListView.builder(
                    //     itemCount: ingredient.length, // 리스트 생성 후에 포커스하려면 +2로 해야하나?
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Column(
                    //         // key: Key('${ingredient[index]}$index}${weight[index]}'),
                    //         key: Key(index.toS),
                    //         children: [
                    //           Row(
                    //             children: [
                    //               // Container(
                    //               //   width: 165.w,
                    //               //   height: 60.h,
                    //               //   decoration: const BoxDecoration(
                    //               //     border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                    //               //   ),
                    //               //   // color: Colors.red,
                    //               //   // child: Center(child: Text(listTest[index]['이름'])),
                    //               //   child: TextField(
                    //               //     textInputAction: TextInputAction.next,
                    //               //     textAlign: TextAlign.center,
                    //               //     onChanged: (value) {
                    //               //       // testA = value;
                    //               //       setState(() {
                    //               //         if(ingredient.length <= index){
                    //               //           ingredient.add("");
                    //               //           weight.add("");
                    //               //         }
                    //               //         ingredient[index] = value;
                    //               //       });
                    //               //     },
                    //               //     decoration: const InputDecoration(
                    //               //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //               //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //               //     ),
                    //               //   ),
                    //               // ),
                                  
                    //               // Container(
                    //               //   width: 165.w,
                    //               //   height: 60.h,
                    //               //   decoration: const BoxDecoration(
                    //               //     border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                    //               //   ),
                    //               //   // color: Colors.green,
                    //               //   // child: Center(child: Text(listTest[index]['중량'])),
                    
                    //               //   child: TextField(
                    //               //     textInputAction: TextInputAction.next,
                    //               //     textAlign: TextAlign.center,
                    //               //     onChanged: (value) {
                    //               //       // testB = value;
                    //               //       setState(() {
                    //               //         if(weight.length <= index){
                    //               //           ingredient.add("");
                    //               //           weight.add("");
                    //               //         }
                    //               //         weight[index] = value;
                    //               //       });
                    //               //     } ,
                    //               //     decoration: const InputDecoration(
                    //               //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //               //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //               //     ),
                    //               //   ),
                    //               // ),
                    //             ]
                    //           ),
                    //           const Divider(height: 10,),
                    //         ],
                    //       );
                    //     }
                    //   )
                    // ],
                  ),
                  // child : ListView.builder(
                  //   itemCount: weight.length+1, // 리스트 생성 후에 포커스하려면 +2로 해야하나?
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Container(
                  //               width: 165.w,
                  //               height: 60.h,
                  //               decoration: const BoxDecoration(
                  //                 border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                  //               ),
                  //               // color: Colors.red,
                  //               // child: Center(child: Text(listTest[index]['이름'])),
                  //               child: TextField(
                  //                 textInputAction: TextInputAction.next,
                  //                 textAlign: TextAlign.center,
                  //                 onChanged: (value) {
                  //                   // testA = value;
                  //                   setState(() {
                  //                     if(ingredient.length <= index){
                  //                       ingredient.add("");
                  //                       weight.add("");
                  //                     }
                  //                     ingredient[index] = value;
                  //                   });
                  //                 },
                  //                 decoration: const InputDecoration(
                  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                  //                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                  //                 ),
                  //               ),
                  //             ),
                              
                  //             Container(
                  //               width: 165.w,
                  //               height: 60.h,
                  //               decoration: const BoxDecoration(
                  //                 border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                  //               ),
                  //               // color: Colors.green,
                  //               // child: Center(child: Text(listTest[index]['중량'])),
                
                  //               child: TextField(
                  //                 textInputAction: TextInputAction.next,
                  //                 textAlign: TextAlign.center,
                  //                 onChanged: (value) {
                  //                   // testB = value;
                  //                   setState(() {
                  //                     if(weight.length <= index){
                  //                       ingredient.add("");
                  //                       weight.add("");
                  //                     }
                  //                     weight[index] = value;
                  //                   });
                  //                 } ,
                  //                 decoration: const InputDecoration(
                  //                   focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                  //                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                  //                 ),
                  //               ),
                  //             ),
                  //           ]
                  //         ),
                  //         const Divider(height: 10,),
                  //       ],
                  //     );
                  //   }
                  // )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}