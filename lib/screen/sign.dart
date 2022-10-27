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
  bool isBtnHovered = false;
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
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height:isKeyboardVisible ?70 : 250,
                  child: isKeyboardVisible
                    ? Container(
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Text('Baking Weighing Assistant',
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'carter',
                              fontSize: 20
                            ),
                          ),
                      ),
                    )
                    : Container(
                      margin: EdgeInsets.all(10),
                        child: Image.asset('assets/images/logo-large.png')
                      ),
                ),
                
                // 내용
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linearToEaseOut,
                  width: 350,
                  height: isSigninScreen ? 370 : 460,
                  
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30,0,30,30),
                    padding: EdgeInsets.fromLTRB(10,10,10,10),
                    decoration: BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀
                        Container(
                          height: 55,
                            margin: EdgeInsets.only(left: 18,top: 10),
                            child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                              style: TextStyle(
                                fontFamily: 'carter',
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
                                ?'Don’t you have an account?'
                                : 'Do you have an account?',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'carter',
                                  color: Palette.middleblack
                                ),
                              ),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSigninScreen = !isSigninScreen;
                                  });
                                },
                                child : Text(isSigninScreen ?'Sign Up !' :'Sign In !',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'carter',
                                    color: Palette.red
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