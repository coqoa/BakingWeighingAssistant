// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  
  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  
  late double boxWidth = MediaQuery.of(context).size.width;
  late double boxHeight = MediaQuery.of(context).size.height;
  
  late bool isFolded;


  @override
  void initState() {
    super.initState();
    isFolded = true;
  }

  @override
  Widget build(BuildContext context) {
    
    
    
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) { 
        return Column(
          children: [
            // 로고
            // !isKeyboardVisible?
            Expanded(
              flex: 1,
              child: SizedBox(
                // height: boxHeight*0.15 ,
                width: boxWidth * 0.6,
                child: Image.asset('assets/images/appbar-logo.png') 
              ),
            ),
            // 내용
            Expanded(
              flex: 10,
              child: Container(
                height: GetPlatform.isMobile? boxHeight*0.67 : 450,
                width: GetPlatform.isMobile? boxWidth : 350,
                padding: EdgeInsets.fromLTRB(10,0,10,10),
                
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Palette.yellow,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 리스트
                            Container(
                              width: boxWidth*0.3,
                              decoration: BoxDecoration(
                                color: Palette.lightyellow,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      // 리스트
                                      child: Text('asd'),
                                  ),
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
                                child: Column(
                                  children: [
                                    Expanded(
                                        // 리스트
                                        child: Text('asd'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      // child: Image.asset('assets/images/appbar-logo.png') 
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                        // 애니메이션추가 / 버튼 3개 배치 / 버튼 바뀌는거 구현하기
                        bottom: 60,
                        right: 10,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.red[200],
                                width: 45,
                                height: 45,
                                child: Image.asset('assets/images/appbar-logo-2.png'),
                              ),
                              onTap: (){
                                print('클릭클릭!!');
                              },
                            ),
                          ],
                        )
                      ),
                      // Positioned(
                      //   bottom: 10,
                      //   right: 10,
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.all(5),
                      //         color: Colors.red[200],
                      //         width: 45,
                      //         height: 45,
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               isFolded = !isFolded;
                      //             });
                      //           },
                      //           child: Container(
                      //             child: isFolded ? Icon(Icons.more) : Icon(Icons.close),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   )
                      // )
                    ],
                  ),
                        
                  // child: SignUp(),
                )
              )
            ),
          ],
          );
       },
    );
  }
}

