// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/widget/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key, required this.boxRadius}) : super(key: key);
  final double boxRadius;
  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  late double boxWidth = MediaQuery.of(context).size.width;
  late double boxHeight = MediaQuery.of(context).size.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) { 
        return Column(
          children: [
            // 로고
            Container(
              height: boxHeight*0.4,
              child: Image.asset('assets/images/large-logo.png'),
            ),
            // Text('Baking', style: TextStyle(fontFamily: 'carter'),),
            // Text('Weighing Assistant'),
            // 내용
            Expanded(
              child: Container(
                height: GetPlatform.isMobile? boxHeight*0.57 : 450,
                width: GetPlatform.isMobile? boxWidth : 350,
                padding: EdgeInsets.all(20),
                
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )
              )
            ),
          ],
          // mainAxisAlignment: GetPlatform.isMobile 
          // ? MainAxisAlignment.end
          // : MainAxisAlignment.center,
          //   // ignore: prefer_const_literals_to_create_immutables
          //   children: [
          //     // !isKeyboardVisible 
          //     // ? Expanded(
          //     //   flex: 1,
          //     //   child: Text('is Mobile? : ${GetPlatform.isMobile}')
          //     // )
          //     // : SizedBox(),
          //     // Expanded(
          //     //   flex: 2,
          //     //   child: Container(
          //     //     width: GetPlatform.isMobile ? boxWidth : 400,
          //     //     decoration: BoxDecoration(
          //     //       color: Palette.yellow,
          //     //       borderRadius: BorderRadius.only(
          //     //         topLeft: Radius.circular(widget.boxRadius),
          //     //         topRight: Radius.circular(widget.boxRadius)
          //     //       ),
          //     //     ),
          //     //     padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          //     //     child: Center(
          //     //       child: Container(
          //     //         // color: Colors.white,
          //     //         padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          //     //         child: SignIn(),
          //     //       ),
          //     //     ),
          //     //   ),
          //     // )
          //     Container(
          //       // color: Colors.black,
          //       width: GetPlatform.isMobile ? boxWidth : 400,
          //       height: GetPlatform.isMobile ? boxHeight : 400,
          //       child: Column(
          //         children: [
          //           // Container(
          //           //   height: 100,
          //           //   color: Colors.red,
          //           // ),
          //           // SizedBox(height: 30),
          //           // Container(
          //           //   height: 100,
          //           //   color: Colors.blue,
          //           // ),
          //         ],
          //       )
          //     ),
          //   ],
          );
       },
    );
  }
}