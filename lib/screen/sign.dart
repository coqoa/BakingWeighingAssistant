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
                  height:isKeyboardVisible ?boxHeight*0.1 : boxHeight*0.4,
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
                  height: isKeyboardVisible ? boxHeight*0.55 :   boxHeight*0.6,
                  //  이쪽 진행중 
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
                          width: 300,
                          height: 50,
                            // margin: EdgeInsets.only(left: 18,top: 10),
                            child: Text(isSigninScreen? 'Sign In' : 'Sign Up',
                            textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Palette.navy,
                                fontFamily: 'nanumSquareRound',
                                fontWeight: FontWeight.w900,
                                fontSize: 30
                                
                              ),
                            )
                        ),
                        // 상단 / 하단 크기 정하고 가운데만 Expanded 적용하기

                        // 텍스트폼필드
                        Expanded(
                          flex: 13,
                          // child: isSigninScreen ? SignIn() : SignUp()
                          child: Column(  
                              children: [
                                // !isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                // 텍스트 폼 필드
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      color: Colors.orange,
                                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // const Text('E-Mail Address',
                                            //   style: TextStyle(
                                            //     fontSize: 13,
                                            //     fontWeight: FontWeight.w300,
                                            //     color: Palette.black
                                            //   ),
                                            // ),
                                            // SizedBox(height: 5),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 40,
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
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.only(left: 20),
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
                                                Container(
                                                  // height: 30,
                                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                  color: Colors.blue,
                                                  child: Text('에러메시지출력',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                      color: Palette.red
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            // isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 10),
                                            // 비밀번호
                                            // const Text('Password',
                                            //   style: TextStyle(
                                            //     fontSize: 13,
                                            //     fontWeight: FontWeight.w300,
                                            //     color: Palette.black
                                            //   ),
                                            // ),
                                            // const SizedBox(height: 5),
                                            // Container(
                                            //   height: 40,
                                            //   // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                            //   child: TextField(
                                            //     key: const ValueKey(2),
                                            //     keyboardType: TextInputType.emailAddress,
                                            //     obscureText: true,
                                            //     cursorColor: Palette.middleblack,
                                            //     cursorWidth: 2,
                                            //     cursorHeight: 15,
                                            //     autocorrect: false,

                                            //     style: const TextStyle(
                                            //       fontSize: 11,
                                            //       // fontFamily: 'carter'
                                            //       fontFamily: 'notosans',
                                            //       fontWeight: FontWeight.w600,
                                            //     ),
                                            //     decoration: InputDecoration(
                                            //       contentPadding: const EdgeInsets.only(left: 10),
                                            //       hintText: '******',
                                            //       hintStyle: const TextStyle(
                                            //         color: Palette.gray,
                                            //         fontSize: 11,
                                            //         // fontFamily: 'carter'
                                            //         fontFamily: 'notosans',
                                            //         fontWeight: FontWeight.w600,
                                            //       ),
                                            //       enabledBorder: OutlineInputBorder(
                                            //         borderSide: const BorderSide(color: Colors.transparent),
                                            //         borderRadius: BorderRadius.circular(10)
                                            //       ),
                                            //       focusedBorder: OutlineInputBorder(
                                            //         borderSide: const BorderSide(color: Colors.transparent),
                                            //         borderRadius: BorderRadius.circular(10)
                                            //       ),
                                            //       filled: true,
                                            //       fillColor: Palette.lightyellow
                                            //     ),
                                                
                                            //     onChanged: (value){
                                            //       // userPassword = value;
                                            //     },
                                            //   ),
                                            // ),


                                            Column(
                                              children: [
                                                Container(
                                                  height: 40,
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
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.only(left: 20),
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
                                                Container(
                                                  color: Colors.blue,
                                                  // height: 30,
                                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                  // color: Colors.red,
                                                  child: Text('에러메시지출력',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                      color: Palette.red
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                                                                        Column(
                                              children: [
                                                Container(
                                                  height: 40,
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
                                                    decoration: InputDecoration(
                                                      contentPadding: const EdgeInsets.only(left: 20),
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
                                                Container(
                                                  color: Colors.blue,
                                                  // height: 30,
                                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                  // color: Colors.red,
                                                  child: Text('에러메시지출력',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                      color: Palette.red
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                // 버튼
                                SizedBox(
                                  width: 235,
                                  height: 40,
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
                                
                              ],
                            ),
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