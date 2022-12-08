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
            padding: EdgeInsets.fromLTRB(30,0,30,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height:isKeyboardVisible ?boxHeight*0.1 : boxHeight*0.3,
                  // color: Colors.red,
                  child: Container(
                    color: Colors.red.withOpacity(0.5),
                      // margin: EdgeInsets.all(10),
                      child: Center(
                        child: isKeyboardVisible 
                          ? Text('gramming',) 
                          : Text('이미지')
                      ),
                    )
                ),

                // Sign Box
                Expanded(
                  child: Container(
                    width: 350,
                    height: isKeyboardVisible ? boxHeight*0.55 :   boxHeight*0.55,
                    //  이쪽 진행중 
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.fromLTRB(30,30,30,15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Title
                          Container(
                            width: 300,
                            height: 40,
                              // margin: EdgeInsets.only(left: 18,top: 10),
                              child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                              textAlign: TextAlign.center,
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
                            flex: 1,
                            // child: isSigninScreen ? SignIn() : SignUp()
                            child: Container(
                              // color: Colors.green,
                              child: Column(  
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // !isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                    // 텍스트 폼 필드
                                    // 이메일
                                    Container(
                                      height: 80,
                                      color: Colors.red,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                child: TextField(
                                                  key: const ValueKey(1),
                                                  keyboardType: TextInputType.emailAddress,
                                          
                                                  cursorColor: Palette.gray,
                                                  cursorWidth: 2,
                                                  cursorHeight: 15,
                                                  autocorrect: false,
                                          
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    // contentPadding: const EdgeInsets.only(left: 20),
                                                    hintText: 'E-mail Address',
                                                    hintStyle: const TextStyle(
                                                      color: Palette.gray,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Palette.gray),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.black),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    filled: true,
                                                    fillColor: Palette.white
                                                  ),
                                                  
                                                  onChanged: (value){
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Palette.red
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    // 비밀번호
                                    Container(
                                      height: 80,
                                      // color: Colors.black,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                child: TextField(
                                                  key: const ValueKey(2),
                                                  keyboardType: TextInputType.emailAddress,
                                                  obscureText: true,
                                                  cursorColor: Palette.gray,
                                                  cursorWidth: 2,
                                                  cursorHeight: 15,
                                                  autocorrect: false,
                                          
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    // contentPadding: const EdgeInsets.only(left: 20),
                                                    hintText: 'Password',
                                                    hintStyle: const TextStyle(
                                                      color: Palette.gray,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Palette.gray),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.black),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    filled: true,
                                                    fillColor: Palette.white
                                                  ),
                                                  
                                                  onChanged: (value){
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Palette.red
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    // 비밀번호 체크
                                    Container(
                                      height: 80,
                                      // color: Colors.blue,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                child: TextField(
                                                  key: const ValueKey(3),
                                                  keyboardType: TextInputType.emailAddress,
                                                  obscureText: true,
                                                  cursorColor: Palette.gray,
                                                  cursorWidth: 2,
                                                  cursorHeight: 15,
                                                  autocorrect: false,
                                          
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                 // contentPadding: const EdgeInsets.only(left: 20),
                                                    hintText: 'Password Check',
                                                    hintStyle: const TextStyle(
                                                      color: Palette.gray,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Palette.gray),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.black),
                                                      borderRadius: BorderRadius.circular(50)
                                                    ),
                                                    filled: true,
                                                    fillColor: Palette.white
                                                  ),
                                                  
                                                  onChanged: (value){
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Palette.red
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    
                                  ],
                                ),
                            ),
                          ),

                          // 버튼
                          Container(
                            width: 255,
                            height: 50,
                            margin: EdgeInsets.only(top: 10, bottom: 15),
                            child:ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.navy,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                                )
                              ),
                              onHover: (hover){
                              },
                              onPressed: (){
                                // signinBtnClick();
                              }, 
                              child: const Text('Next',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900
                                ),
                              )
                            )
                          ),

                          // 회원가입 / 로그인으로 가기 버튼
                          Row(
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
                          )
                        ],
                      ),
                    )
                  ),
                ),

                // admob
                Container(
                  // margin: EdgeInsets.only(top: 10),
                  height: 30,
                  width: 360,
                  color: Colors.blue.withOpacity(0.5),
                  child: Center(child: Text('Admob Banner',)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}