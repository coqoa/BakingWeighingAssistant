// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key, required this.menuTitle});

  final String menuTitle;

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email = FirebaseAuth.instance.currentUser?.email;

  String title = '';
  List ingredient = [];
  List weight = [];
  late dynamic recipeList = [];

  void createRecipe()async {
    if(title.isNotEmpty){
      // ALERT : 존재하는 타이틀
      if(recipeList.contains(title)){
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
        // 레시피 리스트에 추가 
        await recipeList.add(title);
        // 레시피 리스트 Doc 업데이트생성
        await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('RecipeList').set(
          {'RecipeList':recipeList}
        );
        // 레시피 Doc 추가 // 중복안됨
        await firestore.collection('users').doc(email).collection(widget.menuTitle).doc('Recipe').update(
          {title:{'multipleValue': 1,'divideWeight': 1,'ingredient':ingredient,'weight':weight}}
        );
        Get.offAll(()=>Recipe(menuTitle: widget.menuTitle));
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
  }

  @override
  void initState(){
    super.initState();
    firestore.collection('users').doc(email).collection(widget.menuTitle).doc('RecipeList').get().then((value){
      setState(() {
        recipeList = value.data()!['RecipeList'];
        ingredient.add('');
        weight.add('');
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
        // 뒤로가기버튼
        leading:  GestureDetector(
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
                color: Palette.darkgray,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ),

        title: Text('Add',
          style: TextStyle(
            color: Palette.darkgray
          ),
        ),

        // 완료 버튼
        actions: [
          GestureDetector(
            onTap: (){
              createRecipe();
            },
            child: Container(
              width: 50,
              height: 50,
              color: Palette.white,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/check1.svg',
                  color: ((){
                    if(title.isEmpty){
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
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 25
                      ),
                      onChanged: (value) => setState(() {
                        title = value;
                      }),
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
                      children: [
                        SizedBox(
                          width: 165.w,
                          height: 60.h,
                          child: const Center(
                            child: Text('Ingredient',
                              style: TextStyle(
                                fontSize: 15
                              ),
                            )
                          )
                        ),
                        SizedBox(
                          width: 165.w,
                          height: 50.h,
                          child: const Center(
                            child: Text('g',
                              style: TextStyle(
                                fontSize: 15
                              ),
                            )
                          )
                        ),
                      ]
                    ),
                  ),
                  
                  // 시트 바디
                  Container(
                    width: 330.w,
                    height: 290.h,
                    // color: Colors.blue,
                    child : ListView.builder(
                      itemCount: weight.length+1,
                      itemBuilder: (BuildContext context, int index) {

                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 165.w,
                                  height: 60.h,
                                  decoration: const BoxDecoration(
                                    border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                                  ),
                                  // color: Colors.red,

                                  // 재료 TextField
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        if(ingredient.length <= index){
                                          ingredient.add("");
                                          weight.add('');
                                        }
                                        ingredient[index] = value;
                                      });
                                    },
                                  ),
                                ),
                                
                                // 중량 TextField
                                Container(
                                  width: 165.w,
                                  height: 60.h,
                                  decoration: const BoxDecoration(
                                    border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                                  ),
                  
                                  child: TextField(
                                    // keyboardType: const TextInputType.numberWithOptions(
                                    //   signed: true
                                    // ),
                                    // 정규식
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))], 
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        if(weight.length <= index){
                                          ingredient.add("");
                                          weight.add('');
                                        }
                                        // weight[index] = value;
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