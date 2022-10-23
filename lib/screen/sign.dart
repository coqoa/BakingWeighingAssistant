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
  bool isSigninScreen = true;
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
        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로고
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/logo-large.png'),
                ),
                
                // 내용
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut,

                  // width: GetPlatform.isMobile? boxWidth : 350,
                  // height: 
                  //   isSigninScreen 
                  //   ? GetPlatform.isMobile? boxHeight*0.67 : 450
                  //   : GetPlatform.isMobile? boxHeight*0.67 : 480,
                  width: 350,
                  height: isSigninScreen ? 380 : 450,
                  
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30,20,30,30),
                    padding: EdgeInsets.fromLTRB(10,10,10,10),
                    decoration: BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: BorderRadius.circular(20),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Palette.lightgray,
                      //     offset: Offset(2, 2),
                      //     spreadRadius: 1,
                      //     blurRadius: 2,
                      //   )
                      // ]
                    ),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                              fontFamily: 'carter',
                              fontSize: 30
                            ),
                          )
                        ),
                        Expanded(
                          flex: 13,
                          child: isSigninScreen ? SignIn() : SignUp()
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isSigninScreen
                                ?'Don’t you have an account?'
                                : 'Do you have an account?',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'carter',
                                  // fontFamily: 'notosans',
                                  // fontWeight: FontWeight.w600,
                                  // color: Palette.lightblack
                                ),
                              ),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSigninScreen = !isSigninScreen;
                                  });
                                },
                                child: Text(
                                  isSigninScreen ? 'Sign Up!' : 'Sign In!',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'carter',
                                    // fontFamily: 'notosans',
                                    // fontWeight: FontWeight.w600,
                                    color: Palette.red
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}