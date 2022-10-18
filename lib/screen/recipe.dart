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
  
  @override
  void initState() {
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.yellow,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                          child: Text('asd'),
                        ),
                        Expanded(
                          child: Text('asd'),
                        ),
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

