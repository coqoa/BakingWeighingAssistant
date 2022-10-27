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
                ),
                Center(
                  child: Text('ADD',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'carter',
                        fontSize: GetPlatform.isMobile ? 20 : 35
                      ),
                    ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            )
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
                        child: SingleChildScrollView(
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
