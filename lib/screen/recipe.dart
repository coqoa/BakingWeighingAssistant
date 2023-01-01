// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../config/enum.dart';


class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  
  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {


  RecipeController controller = RecipeController();
  // firebase Auth
  String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

  late int multipleCount;

  @override
  void initState() {
    super.initState();
    multipleCount = 1;
  }

  @override
  Widget build(BuildContext context) {

    
    void countChange(int e){
        setState(() {
          // 파라미터가 0 이거나, 카운트 값과 파라미터의 합이 0이하이면 초기화 시킨다
          if(e == 0 || multipleCount+e < 1){
            multipleCount = 1;
          // 더하기
          }else if(multipleCount+e > 0){
            multipleCount = multipleCount + e;
          }
        });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 상단 바 
          Container(
            // height: 100,
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Palette.white,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset:Offset(0.0, 1.0),
                  color: Color.fromRGBO(219, 219, 219, 1)
                )
              ]
            ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 70,
                        height: 30,
                        // color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 14,
                                width: 14,
                                child: SvgPicture.asset(
                                  'assets/images/ic_arrow_left2.svg',
                                  color: Palette.darkgray,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                                child: Text(' back',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.darkgray,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),

                      Text('Boulangerie',
                        style: const TextStyle(
                          fontFamily: 'jalnan',
                          color: Palette.black,
                          fontSize: 25,
                        ),
                      ),

                      Container(
                        width: 70,
                        height: 30,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              margin: EdgeInsets.only(bottom: 1),
                              // color: Colors.blue,
                              child: SvgPicture.asset(
                                'assets/images/ic_clipboard.svg',
                                color: Palette.darkgray,
                              ),
                            ),
                            Container(
                              height: 18,
                              width: 18,
                              margin: EdgeInsets.only(top: 1),
                              // color: Colors.green,
                              child: SvgPicture.asset(
                                'assets/images/ic_bars.svg',
                                color: Palette.darkgray,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 리스트 인디케이터
                Container(
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  // color: Colors.orange,
                  child: Center(
                    child: Container(
                      width: 230,
                      height: 36,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Palette.reallightgray,
                        borderRadius: BorderRadius.circular(20),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset:Offset(0.0, 1.0),
                            color: Color.fromRGBO(219, 219, 219, 1)
                          )
                        ]
                      ),
                      // controller
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.testList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            // 메뉴 버튼
                            child: Container(
                              height: 36,
                              padding: EdgeInsets.only(right: 10),
                              child: Center(
                                child: Obx((){
                                  return Text(
                                    controller.testList[index],
                                    style: TextStyle(
                                      color: controller.testListSelected.value == index ? Palette.black : Palette.darkgray, // darkgray
                                      fontWeight: controller.testListSelected.value == index ? FontWeight.w900 : FontWeight.w400, // regular
                                      fontSize: 14
                                    ),
                                  );
                                })
                              ),
                            ),
                            // EVENT
                            onTap: () {
                              controller.testListSelected.value = index;
                              print(controller.testList[index]);
                            },
                          );
                        }
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          
          // 메인 컨텐츠
          Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),

          // 하단 계산기
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Palette.white,
              border: Border(
                
                // top: BorderSide(color: Palette.reallightgray, width: 2)
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset:Offset(0.0, -1.0),
                  color: Color.fromRGBO(219, 219, 219, 1)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // -5
                GestureDetector(
                  child: MultipleButton(btnText: '-5'),
                  onTap: (){
                    countChange(-5);
                  },
                ),
                // -1
                GestureDetector(
                  child: MultipleButton(btnText: '-1'),
                  onTap: (){
                    countChange(-1);
                  },
                ),
                // indicator
                GestureDetector(
                  child:  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Palette.white,
                      color: multipleCount == 1 ? Palette.white : Palette.black,
                      // border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 7,
                      //     offset:Offset(0.0, 3.0),
                      //     color: multipleCount == 1 ? Color.fromRGBO(219, 219, 219, 1) : Palette.black.withOpacity(0.3) 
                      //   )
                      // ]
                    ),
                    child: Center(
                      child: Text('$multipleCount',
                        style: TextStyle(
                          fontFamily: 'jalnan',
                          fontSize: 17,
                          // color: Palette.white,
                          color: multipleCount == 1 ? Palette.black : Palette.white,
                          
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    countChange(0);
                  },
                ),
                // +1
                GestureDetector(
                  child: MultipleButton(btnText: '+1'),
                  onTap: (){
                    countChange(1);
                  },
                ),
                // +5
                GestureDetector(
                  child: MultipleButton(btnText: '+5'),
                  onTap: (){
                    countChange(5);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MultipleButton extends StatelessWidget {
  const MultipleButton({super.key, required this.btnText});
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(child: Text(btnText,style: TextStyle(fontSize: 14)))
    );
  }
}