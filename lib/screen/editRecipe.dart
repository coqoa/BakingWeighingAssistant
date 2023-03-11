// ignore_for_file: avoid_print

import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({super.key, required this.menuTitle, required this.recipeTitle, required this.multipleValue, required this.divideWeight});

  final String menuTitle;
  final String recipeTitle;
  final dynamic multipleValue;
  final dynamic divideWeight;

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email = FirebaseAuth.instance.currentUser?.email;

  String originalTitle = '';
  String title = '';
  List ingredient = [];
  List weight = [];
  late List recipeList = [];

  late TextEditingController _controller;
  
  Rx<RequestStatus> requestStatus = RequestStatus.EMPTY.obs;
  // 완료버튼
  void modifyRecipe()async {
    requestStatus.value=RequestStatus.LOADING;
    if(title.isNotEmpty){
      // originalTitle != title => 레시피 변경시 현재 타이틀을 다시 쓰기 위한 코드
      if(recipeList.contains(title) && originalTitle != title){
        // ALERT : 존재하는 타이틀
        Get.snackbar(
          "","",
          titleText: const Center(
            child: Text("ERROR", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              )
            )
          ),
          messageText: Center(child: Text("'$title' already exists")),
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticIn,
          reverseAnimationCurve: Curves.easeOut,
          backgroundColor: Palette.lightgray,
          margin: EdgeInsets.only(bottom: 20.h),
          maxWidth: 300.w,
        );
      }else{
        // 레시피 리스트에 타이틀 변경
        recipeList[recipeList.indexOf(originalTitle)]=title;

        // RecipeList 업데이트
        await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('RecipeList').set(
          {'RecipeList':recipeList}
        );
        // original 데이터 제거
        await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').update({
          originalTitle: FieldValue.delete(),
        });
        // new 데이터 입력
        await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').update(
          {title:{'multipleValue': widget.multipleValue, 'divideWeight': widget.divideWeight, 'ingredient':ingredient,'weight':weight}}
        );
        // Get.offAll(()=>Recipe(menuTitle: widget.menuTitle));
        Get.to(()=>Recipe(menuTitle: widget.menuTitle,));
      }
    }else{
      // ALERT : 타이틀을 입력해주세요
      Get.snackbar(
        "","",
        titleText: const Center(
          child: Text("ERROR", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            )
          )
        ),
        messageText: Center(child: Text("Please enter a Title")),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticIn,
        reverseAnimationCurve: Curves.easeOut,
        backgroundColor: Palette.lightgray,
        margin: EdgeInsets.only(bottom: 20.h),
        maxWidth: 300.w,
      );
    }
    requestStatus.value=RequestStatus.SUCCESS;
  }

  @override
  void initState(){
    super.initState();
    firestore.collection('users').doc(email).collection(widget.menuTitle).doc('RecipeList').get().then((value){
      setState(() {
        recipeList = value.data()!['RecipeList'];
      });
    });

    originalTitle = widget.recipeTitle;
    title = widget.recipeTitle;

    _controller = TextEditingController(text: title);

    firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').get().then((value){
      setState(() {
        ingredient = value[widget.recipeTitle]['ingredient'];
        weight = value[widget.recipeTitle]['weight'];
        // 재료와 중량 리스트 모두 마지막이 비었을 때만 추가해줌
        if(ingredient.last.length!=0 && weight.last.length!=0){
          ingredient.add('');
          weight.add('');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 2,
        centerTitle: true,
        // 뒤로가기 버튼
        leading:  Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              width: 50,
              height: 50,
              color: Palette.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/images/left1.svg',
                  color: Palette.lightblack,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
        ),
        title: const Text('Edit',
          style: TextStyle(
            color: Palette.lightblack,
            fontWeight: FontWeight.w600,
            fontSize: 23
          ),
        ),
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:5),
            child: GestureDetector(
              onTap: (){
                modifyRecipe();
              },
              // child: Container(
              //   width: 50,
              //   height: 50,
              //   color: Palette.white,
              //   child: Center(
              //     child: ((){
              //       if(ingredient.isEmpty || weight.isEmpty || title.isEmpty){
              //         return const Icon(Icons.check_outlined, color: Palette.lightgray, size: 30);
              //       }else{
              //         return Icon(Icons.check_outlined, color: Colors.green[600], size: 30);
              //       }
              //     }())
              //   ),
              // ),
              child: Container(
                width: 50,
                height: 50,
                color: Palette.white,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/check1.svg',
                    color: ((){
                      if(ingredient.isEmpty || weight.isEmpty || title.isEmpty){
                        return Palette.lightgray;
                      }else{
                        return Colors.green[600];
                      }
                    }()),
                    width: 30,
                    height: 30,
                  ),
                ),
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
            child: SingleChildScrollView(
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
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.transparent),
                        ),
                        hintText: "Title"
                      ),
                      onChanged: (value) => title = value,
                    ),
                  ),

                  // 시트 헤더
                  Container(
                    width: 330.w,
                    decoration: const BoxDecoration(
                      // color: Colors.red,
                      border: Border(bottom: BorderSide(width: 1, color: Palette.lightgray))
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 165.w,
                          height: 60.h,
                          child: const Center(child: Text('Ingredient',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ))
                        ),
                        SizedBox(
                          width: 165.w,
                          height: 50.h,
                          child: const Center(child: Text('g',
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
                    // 리오더블
                    // color: Colors.blue,
                    // child: 
                    // ReorderableListView(
                    //   onReorder: (int oldIndex, int newIndex) { 
                    //     // setState(() {
                    //     setState(() {
                    //       if (newIndex > oldIndex) {
                    //         newIndex -= 1;
                    //       }
                    //       final moveIngredient = ingredient.removeAt(oldIndex);
                    //       final moveWeight = weight.removeAt(oldIndex);
                    //       ingredient.insert(newIndex, moveIngredient);
                    //       weight.insert(newIndex, moveWeight);
                          
                    //     });
                    //     //   // print(controller.menuList);
                    //       // controller.dragAndDropMenu(); // db업데이트 
                          
                    //     // });
            
                    //    },
                    //   children: List.generate(ingredient.length, (item)=>Container(
                    //       key: Key('${ingredient[item]}$item}${weight[item]}'),
                    //       // child: Text('$item : ${ingredient[item]}, ${weight[item]}'),
                    //       child: Row(
                    //         children: [
                    //           Text('$item 위아래'),
                    //           Container(
                    //             width: 100,
                    //             child: TextFormField(
                    //               initialValue: ingredient[item],
                    //               onChanged: (value){
                    //                 setState(() {
                    //                   print(item);
                    //                   print(ingredient);
                    //                   print(ingredient[item]);
                    //                   print(value);
                    //                   ingredient.add('');
                                      
                    //                   // if(ingredient.length <= item){
                    //                       // ingredient.add("");
                    //                       // weight.add("");
                    //                     // }
                    //                   // ingredient[item] = value;
                                      
                    //                 });
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //     )),
                    //   // children: [
                    //   //   ListView.builder(
                    //   //     itemCount: ingredient.length, // 리스트 생성 후에 포커스하려면 +2로 해야하나?
                    //   //     itemBuilder: (BuildContext context, int index) {
                    //   //       return Column(
                    //   //         // key: Key('${ingredient[index]}$index}${weight[index]}'),
                    //   //         key: Key(index.toS),
                    //   //         children: [
                    //   //           Row(
                    //   //             children: [
                    //   //               // Container(
                    //   //               //   width: 165.w,
                    //   //               //   height: 60.h,
                    //   //               //   decoration: const BoxDecoration(
                    //   //               //     border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                    //   //               //   ),
                    //   //               //   // color: Colors.red,
                    //   //               //   // child: Center(child: Text(listTest[index]['이름'])),
                    //   //               //   child: TextField(
                    //   //               //     textInputAction: TextInputAction.next,
                    //   //               //     textAlign: TextAlign.center,
                    //   //               //     onChanged: (value) {
                    //   //               //       // testA = value;
                    //   //               //       setState(() {
                    //   //               //         if(ingredient.length <= index){
                    //   //               //           ingredient.add("");
                    //   //               //           weight.add("");
                    //   //               //         }
                    //   //               //         ingredient[index] = value;
                    //   //               //       });
                    //   //               //     },
                    //   //               //     decoration: const InputDecoration(
                    //   //               //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //   //               //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //   //               //     ),
                    //   //               //   ),
                    //   //               // ),
                                    
                    //   //               // Container(
                    //   //               //   width: 165.w,
                    //   //               //   height: 60.h,
                    //   //               //   decoration: const BoxDecoration(
                    //   //               //     border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                    //   //               //   ),
                    //   //               //   // color: Colors.green,
                    //   //               //   // child: Center(child: Text(listTest[index]['중량'])),
                      
                    //   //               //   child: TextField(
                    //   //               //     textInputAction: TextInputAction.next,
                    //   //               //     textAlign: TextAlign.center,
                    //   //               //     onChanged: (value) {
                    //   //               //       // testB = value;
                    //   //               //       setState(() {
                    //   //               //         if(weight.length <= index){
                    //   //               //           ingredient.add("");
                    //   //               //           weight.add("");
                    //   //               //         }
                    //   //               //         weight[index] = value;
                    //   //               //       });
                    //   //               //     } ,
                    //   //               //     decoration: const InputDecoration(
                    //   //               //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //   //               //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                    //   //               //     ),
                    //   //               //   ),
                    //   //               // ),
                    //   //             ]
                    //   //           ),
                    //   //           const Divider(height: 10,),
                    //   //         ],
                    //   //       );
                    //   //     }
                    //   //   )
                    //   // ],
                    // ),
            
                    child : ListView.builder(
                      itemCount: weight.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                // 좌항(재료)
                                Container(
                                  width: 165.w,
                                  height: 60.h,
                                  decoration: const BoxDecoration(
                                    border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                                  ),
                                  // color: Colors.red,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    initialValue: ingredient[index],
                                    autocorrect: false,
                                    onChanged: (value) {
                                      setState(() {
                                        if(ingredient.length <= index+1){
                                          ingredient.add("");
                                          weight.add("");
                                        }
                                        ingredient[index] = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                    ),
                                  ),
                                ),
                                
                                // 우항(중량)
                                Container(
                                  width: 165.w,
                                  height: 60.h,
                                  decoration: const BoxDecoration(
                                    border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                                  ),
                                  // color: Colors.green,
                  
                                  child: TextFormField(
                                    keyboardType: const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true
                                    ),
                                    // 정규식
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))], 
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                    ),
                                    initialValue: weight[index],
                                    onChanged: (value) {
                                      setState(() {
                                        if(weight.length <= index+1){
                                          ingredient.add("");
                                          weight.add("");
                                        }
                                        weight[index] = value;
                                      });
                                    } ,
                                  ),
                                ),
                              ]
                            ),
                            const Divider(height: 10,),
                          ],
                        );
                      }
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}