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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/images/logo-large.png'),
              ),
              
              // 내용
              Container(
                height: GetPlatform.isMobile? boxHeight*0.67 : 450,
                width: GetPlatform.isMobile? boxWidth : 350,

                padding: EdgeInsets.fromLTRB(20,20,20,0),
                
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.yellow,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        // height: 45,
                        child: Container(
                          // padding: const EdgeInsets.only(left: 10,top: 30),
                          // height: 50,
                          child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                              fontFamily: 'carter',
                              fontSize: 40
                            ),
                          )
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        flex: 13,
                        child: Container(
                          // color: Colors.red,
                            child: isSigninScreen ? SignIn() : SignUp(),
                        )
                      ),
                      SizedBox(height: 5),
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
                                fontSize: 11,
                                fontFamily: 'carter',
                                color: Palette.lightblack
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
                                isSigninScreen
                                ? 'Sign Up!'
                                : 'Sign In!',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'carter',
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
        );
      },
    );
  }
}