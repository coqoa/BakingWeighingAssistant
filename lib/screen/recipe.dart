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
  
  late double boxHeight = MediaQuery.of(context).size.height;
  late double boxWidth = GetPlatform.isMobile? MediaQuery.of(context).size.width : 1000;
  
  late bool moreBtnFolded;


  @override
  void initState() {
    moreBtnFolded = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
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
                                  child: SingleChildScrollView(
                                    child: Column(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        TextField(),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                        Text('asd', style: TextStyle(fontSize: 20),),
                                      ],
                                    ),
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
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text('asdasd', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
                                        Text('asdasa', style: TextStyle(fontSize: 20),),
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
                                        primary: Palette.black,
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
                                        primary: Palette.black,
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
                                        primary: Palette.middleblack,
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

