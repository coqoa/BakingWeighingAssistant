// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
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
  bool isBtnHovered = false;
  late double boxWidth = MediaQuery.of(context).size.width;
  late double boxHeight = MediaQuery.of(context).size.height-60;
  
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
        return Scaffold(
          backgroundColor: Palette.backgroundColor,
          body: Container(
            padding: EdgeInsets.fromLTRB(30,10,30,10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height:isKeyboardVisible ?70 : boxHeight*0.4 - 30,
                  // color: Colors.red,
                  child: Container(
                    color: Colors.red,
                      // margin: EdgeInsets.all(10),
                      child: Center(
                        child: isKeyboardVisible 
                          ? Text('gramming',) 
                          : Text('이미지')
                      ),
                    )
                ),
                SizedBox(height: 10,),
                // Sign Box
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut,

                  width: 350,
                  height: isSigninScreen ? boxHeight*0.6 - 30 : 460,
                  
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10,10,10,10),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 1,
                          blurRadius: 20,
                          offset: Offset(3, 16), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Container(
                          height: 55,
                            margin: EdgeInsets.only(left: 18,top: 10),
                            child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                              style: TextStyle(
                                color: Palette.navy,
                                fontFamily: 'nanumSquareRound',
                                fontWeight: FontWeight.w900,
                                fontSize: 30
                              ),
                            )
                        ),
                        
                        // 텍스트폼필드
                        Expanded(
                          flex: 13,
                          child: isSigninScreen ? SignIn() : SignUp()
                        ),
                        SizedBox(height: 10),
        
                        // 회원가입 / 로그인으로 가기 버튼
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                isSigninScreen
                                ? 'Don’t you have an account?'
                                : 'Do you have an account?',
                                style: TextStyle(
                                  fontSize: 12,
                                  // fontFamily: 'nanumSquareRound',
                                  fontWeight: FontWeight.w600,
                                  color: Palette.middleblack
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSigninScreen = !isSigninScreen;
                                  });
                                },
                                child : Text(isSigninScreen ?'Sign Up !' :'Sign In !',
                                  style: TextStyle(
                                    color: Palette.navy,
                                    fontSize: 12,
                                    // fontFamily: 'nanumSquareRound',
                                    fontWeight: FontWeight.w900,
                                    // color: Palette.red
                                  ),
                                )
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