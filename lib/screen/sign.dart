// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/widget/sign_in.dart';
import 'package:bwa/widget/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class Sign extends StatefulWidget {
  Sign({Key? key, required this.boxRadius}) : super(key: key);
  final double boxRadius;

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool isSignin = true;
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
            Center(
              child: SizedBox(
                height: isKeyboardVisible? boxHeight*0.15 : boxHeight*0.3,
                width: boxWidth * 0.8,
                child: isKeyboardVisible 
                  ? Image.asset('assets/images/appbar-logo-2.png') 
                  : Image.asset('assets/images/large-logo.png'),
                // child: Image.asset('assets/images/large-logo.png'),
              ),
            ),
            // 내용
            Expanded(
              child: Container(
                height: GetPlatform.isMobile? boxHeight*0.67 : 450,
                width: GetPlatform.isMobile? boxWidth : 350,
                padding: EdgeInsets.fromLTRB(20,5,20,20),
                
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.yellow,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 50,
                                child: isSignin 
                                ? Image.asset("assets/images/signin-title.png") 
                                : Image.asset("assets/images/signin-title-unfocus.png")
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                isSignin = true;
                              });
                            },
                          ),
                          GestureDetector(
                            child: SizedBox(
                              height: 50,
                              child: Container(
                                padding: const EdgeInsets.only(right: 20),
                                height: 50,
                                child: isSignin 
                                ? Image.asset("assets/images/signup-title-unfocus.png")
                                : Image.asset("assets/images/signup-title.png")
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                isSignin = false;
                              });
                            },
                          ),
                        ],
                      ),
                      Expanded(child: isSignin ? SignIn() : SignUp())
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