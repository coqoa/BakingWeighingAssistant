import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  late double boxHeight = MediaQuery.of(context).size.height;
  late double boxWidth = GetPlatform.isMobile? MediaQuery.of(context).size.width : 1000;

  @override
  void initState() {

    super.initState();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: GestureDetector(
                    onTap: (){
                      // setState(() {
                  //     });
                      print('뒤로가기');
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      // color: Colors.red,
                      child: Center(
                        child: Text('<',
                          style: TextStyle(
                            fontFamily: 'notosans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Palette.middleblack
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                Center(
                  child: Text('ADD',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'carter',
                        fontSize: GetPlatform.isMobile ? 25 : 35
                      ),
                    ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                  child: GestureDetector(
                    onTap: (){
                      // setState(() {
                  //     });
                      print('새로고침');
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      // color: Colors.red,
                      child: Center(
                        child: Text('⟳',
                          style: TextStyle(
                            fontFamily: 'notosans',
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Palette.middleblack
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              ],
            )
          ),
          // 내용
          Expanded(
            flex: 10,
            child: Container(
              height: GetPlatform.isMobile? boxHeight*0.67 : 350,
              width: boxWidth*0.6,
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
                          // Container(
                          //   margin: EdgeInsets.all(10),
                          //   width: 20,
                          //   height: 20,
                          // ),
                          // !listFolded 
                          // ? 
                          SizedBox(height: 10),
                          Expanded(
                              // 리스트
                              child: SingleChildScrollView(
                                child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
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
                        child: Column(
                          children: [
                            // 레시피 이름
                            Container(
                              padding: EdgeInsets.fromLTRB(10,0,10,0),
                              child: TextField(
                                style: TextStyle(
                                  
                                ),
                              ),
                            ),
                            // 레시피 내용
                            Expanded(
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          // Container(
                                          //   height: 60,
                                          //   child: Row(
                                          //     children: [
                                          //        Expanded(
                                          //         flex: 1,
                                          //         child: TextField(
                                          //           textAlign: TextAlign.center,
                                                
                                          //           decoration: InputDecoration(
                                          //             border: OutlineInputBorder(
                                          //               borderRadius: BorderRadius.circular(15), 
                                          //               borderSide: BorderSide(
                                          //                 width: 0,
                                          //                 style: BorderStyle.none
                                          //             )),
                                          //             filled: true,
                                          //             fillColor: Colors.white
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       SizedBox(width: 5,),
                                          //       Expanded(
                                          //         flex: 1,
                                          //         child: TextField(
                                          //           textAlign: TextAlign.center,
                                                
                                          //           decoration: InputDecoration(
                                          //             border: OutlineInputBorder(
                                          //               borderRadius: BorderRadius.circular(15), 
                                          //               borderSide: BorderSide(
                                          //                 width: 0,
                                          //                 style: BorderStyle.none
                                          //             )),
                                          //             filled: true,
                                          //             fillColor: Colors.white
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // 디자인 변경하기 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                color: Palette.darkgray,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                color: Palette.darkgray,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                color: Palette.darkgray,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  // Add 버튼
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Palette.middleblack,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        // fixedSize: Size(0, 0),
                                        // padding: const EdgeInsets.all(0),
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
                                        setState(() {
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            )
          ),
        ]);
      },
    );
  }
}
