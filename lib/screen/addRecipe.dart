// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key, required this.menuTitle});

  final String menuTitle;

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email = FirebaseAuth.instance.currentUser?.email;

  RecipeController controller = RecipeController();

  String title = '';
  List ingredient = [];
  List weight = [];
  late dynamic recipeList = [];

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

    return WillPopScope(
      onWillPop: () async => false, 
      child: Scaffold(
        // header: 
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

          // 페이지 타이틀
          title: Text('Add',
            style: TextStyle(
              color: Palette.lightblack,
              fontWeight: FontWeight.w600,
              fontSize: 23
            ),
          ),
    
          // 완료 버튼
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:5),
              child: GestureDetector(
                onTap: (){
                  controller.createRecipe(title, widget.menuTitle, recipeList, ingredient, weight);
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
            ),
          ],
        ),

        // main: 
        body: SafeArea(
          child: Align( 
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 580.h,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
              
                    // 레시피 타이틀 입력공간
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
                    
                    // 레시피 시트
                    SizedBox(
                      width: 330.w,
                      height: 290.h,
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

                                    // 재료명 TextField
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
                                      onChanged: (value) {
                                        setState(() {
                                          if(weight.length <= index){
                                            ingredient.add("");
                                            weight.add('');
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
      ),
    );
  }
}