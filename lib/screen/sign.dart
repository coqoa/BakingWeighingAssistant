// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/sign_controller.dart';
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
  bool isSignin = true;
  bool isBtnHovered = false;
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height-60;

  final SignController controller = SignController(); 

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
                // TODO Logo
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  height:isKeyboardVisible ? 0 : boxHeight*0.3,
                  // color: Colors.red,
                  child: Container(
                    color: Colors.red.withOpacity(0.5),
                      child: Center(
                        child: isKeyboardVisible 
                          ? Text('gramming',) 
                          : Text('이미지')
                      ),
                    )
                ),

                // TODO Sign Box
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top:10, bottom: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 300,
                          height: 74,
                          padding: EdgeInsets.only(left: 20, right: 0),
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Title    
                              Text(isSignin? 'Sign In' : 'Sign Up',
                              style: TextStyle(
                                // color: Palette.navy,
                                fontFamily: 'nanumSquareRound',
                                fontWeight: FontWeight.w900,
                                fontSize: 30
                              )),
                            // Next 버튼
                              !isSignin 
                              ?InkWell(
                                onTap: (){
                                  controller.signUp();
                                },
                                child: Container(
                                  width: 85,
                                  height: 35,
                                  child: Center(
                                    child: Text('Next',
                                      style: TextStyle(
                                        color: Palette.gray,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900
                                      ),
                                    ),
                                  ),
                                  // child:ElevatedButton(
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: Palette.white,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(50)
                                  //     )
                                  //   ),
                                  //   onHover: (hover){
                                  //   },
                                  //   onPressed: (){
                                  //     // signinBtnClick();
                                  //   }, 
                                  //   child: const Text('Next',
                                  //     style: TextStyle(
                                  //       color: Palette.navy,
                                  //       // color: Colors.value,
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.w900
                                  //     ),
                                  //   )
                                  // )
                                ),
                              )
                              : SizedBox(),
                            ],
                          )
                        ),
                
                        // TODO 텍스트폼필드
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            // color: Colors.green,
                            child: SingleChildScrollView(
                              child: Column(  
                                  children: [
                                    // 텍스트 폼 필드
                                    // TODO SIGNIN
                                    // 이메일
                                    if(isSignin)
                                    Container(
                                      height: 80,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
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
                                                    controller.signInUserEmail.value = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                          // Positioned(
                                          //   bottom: 0,
                                          //   child: Container(
                                          //     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          //     // color: Colors.blue,
                                          //     child:Obx(()=> 
                                          //       Text(controller.signInUserEmail.value,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //           fontSize: 13,
                                          //           fontWeight: FontWeight.w500,
                                          //           color: Colors.red.withOpacity(0.7)
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                            
                                    if(isSignin)
                                    // 비밀번호
                                    Container(
                                      height: 80,
                                      // color: Colors.black,
                                      margin: EdgeInsets.only(bottom: 10),
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
                                                    controller.signInUserPassword.value = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                          // Obx(()=>
                                          //   Positioned(
                                          //     bottom: 0,
                                          //     child: Container(
                                          //       margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          //       // color: Colors.blue,
                                          //       child: Text(controller.passwordValidationResult.value,
                                          //       textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //           fontSize: 13,
                                          //           fontWeight: FontWeight.w500,
                                          //           color: Colors.red.withOpacity(0.7)
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   )
                                          // )
                                        ],
                                      ),
                                    ),

                                    // TODO SIGN UP
                                    if(!isSignin)
                                    // 이메일
                                    Container(
                                      height: 80,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                child: TextField(
                                                  key: const ValueKey(3),
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
                                                    controller.signUpUserEmail.value = value;
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
                                              // color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red.withOpacity(0.7)
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if(!isSignin)
                                    // 비밀번호
                                    Container(
                                      height: 80,
                                      // color: Colors.black,
                                      margin: EdgeInsets.only(bottom: 10),
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
                                                  key: const ValueKey(4),
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
                                                    controller.signUpUserPassword.value = value;
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
                                              // color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red.withOpacity(0.7)
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            
                                    // 비밀번호 체크
                                    if(!isSignin)
                                    Container(
                                      height: 80,
                                      // color: Colors.blue,
                                      margin: EdgeInsets.only(bottom: 10),
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
                                                  key: const ValueKey(5),
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
                                                    controller.userPasswordRepeat.value = value;
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
                                              // color: Colors.blue,
                                              child: Text('에러메시지출력',
                                              textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red.withOpacity(0.7)
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // if(isSignin)

                                    // 레이아웃 이상해질 위홈 많음
                                    InkWell(
                                      onTap: () {
                                        controller.signIn();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Palette.navy,
                                          borderRadius: BorderRadius.circular(50)
                                          // boxShadow: 
                                        ),
                                        child: Center(
                                          child: Text('Next',
                                          style: TextStyle(
                                            color: Palette.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16
                                          ),),
                                        ), 
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ),

                        // // if(isSignin)
                        // InkWell(
                        //   onTap: () {
                        //     controller.signIn();
                        //   },
                        //   child: Container(
                        //     margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        //     height: 50,
                        //     decoration: BoxDecoration(
                        //       color: Palette.navy,
                        //       borderRadius: BorderRadius.circular(50)
                        //       // boxShadow: 
                        //     ),
                        //     child: Center(
                        //       child: Text('Next',
                        //       style: TextStyle(
                        //         color: Palette.white,
                        //         fontWeight: FontWeight.w900,
                        //         fontSize: 16
                        //       ),),
                        //     ), 
                        //   ),
                        // ),
                        if(!isKeyboardVisible)
                        // 회원가입 / 로그인으로 가기 버튼
                        Container(
                          height: 20,
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                isSignin
                                ? 'Don’t you have an account?'
                                : 'Do you have an account?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.middleblack
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSignin = !isSignin;
                                  });
                                },
                                child : Text(isSignin ?'Sign Up !' :'Sign In !',
                                  style: TextStyle(
                                    // color: Palette.navy,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic
                                  ),
                                )
                              )
                            ],
                          ),
                        )
                        
                      ],
                    ),
                  ),
                ),

                // admob
                isKeyboardVisible 
                ? SizedBox()
                : Container(
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