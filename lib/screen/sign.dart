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
  late double boxHeight = MediaQuery.of(context).size.height;

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
          body: Center(
            child: Container(
              height: boxHeight,
              width: boxWidth,
              // padding: EdgeInsets.only(left: 30, right: 30),
              // height: boxHeight, 앱일때만 설정하기
              color: Colors.amber,

              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Logo
                  Positioned(
                    top: 0,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                        width: 300,
                        height: isKeyboardVisible ? 0 :210,
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

                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 300,
                      height: 365,
                      color: Colors.red,
                      child: ,
                    ),
                  )
                  
                    // Sign Box
                  //   Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     AnimatedContainer(
                  //       duration: Duration(milliseconds: 250),
                  //       curve: Curves.easeIn,
                  //       margin: EdgeInsets.only(top: isKeyboardVisible? 0 : 160),
                  //       padding: EdgeInsets.fromLTRB(0,10,0,10),
                  //       child: Container(
                  //       height: 365,
                  //         // margin: EdgeInsets.only(top: 10),
                  //         padding: EdgeInsets.fromLTRB(10,0,10,0),
                  //         decoration: BoxDecoration(
                  //           color: Palette.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.black.withOpacity(0.16),
                  //               spreadRadius: 1,
                  //               blurRadius: 20,
                  //               offset: Offset(3, 16), // changes position of shadow
                  //             ),
                  //           ],
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                          
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             // 타이틀
                  //             Container(
                  //               height: 55,
                  //               color: Colors.green,
                  //               padding: EdgeInsets.only(left: 20, right: 0),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   // Title    
                  //                   Text(isSignin? 'Sign In' : 'Sign Up',
                  //                   style: TextStyle(
                  //                     fontFamily: 'nanumSquareRound',
                  //                     fontWeight: FontWeight.w800,
                  //                     fontSize: 30
                  //                   )),
                  //                 ],
                  //               )
                  //             ),
                                            
                  //             // 텍스트폼필드
                  //             Container(
                  //               padding: EdgeInsets.only(left: 20, right: 20),
                  //               height: 210,
                  //               color: Colors.blue,
                  //               child: 
                                          
                  //               isSignin
                  //               // 로그인 화면
                  //               ? Column(  
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     // 텍스트 폼 필드
                  //                     // TODO SIGNIN
                  //                     // 이메일
                  //                     Container(
                  //                       // height: 50,
                  //                       color: Colors.grey,
                  //                       child: TextField(
                  //                         key: const ValueKey(1),
                  //                         keyboardType: TextInputType.emailAddress,
                                        
                  //                         cursorColor: Palette.black,
                  //                         cursorWidth: 2,
                  //                         cursorHeight: 15,
                  //                         autocorrect: false,
                                        
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                         // textAlign: TextAlign.center,
                  //                         decoration: InputDecoration(
                  //                           // contentPadding: const EdgeInsets.only(left: 20),
                  //                           hintText: 'E-mail Address',
                  //                           hintStyle: const TextStyle(
                  //                               color: Palette.gray,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                           ),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Palette.gray),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           focusedBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Colors.black),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           filled: true,
                  //                           fillColor: Palette.white,
                  //                           isDense: true,
                  //                           contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
                  //                         ),
                                          
                  //                         onChanged: (value){
                  //                           controller.signInUserEmail.value = value;
                  //                         },
                  //                       ),
                  //                     ),
                                
                  //                     // 비밀번호
                  //                     Container(
                  //                       color: Colors.grey,
                  //                       child: TextField(
                  //                         key: const ValueKey(2),
                  //                         keyboardType: TextInputType.emailAddress,
                                          
                  //                         obscureText: true,
                                          
                  //                         cursorColor: Palette.black,
                  //                         cursorWidth: 2,
                  //                         cursorHeight: 15,
                  //                         autocorrect: false,
                                        
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                         decoration: InputDecoration(
                  //                           // contentPadding: const EdgeInsets.only(left: 20),
                  //                           hintText: 'Password',
                  //                           hintStyle: const TextStyle(
                  //                             color: Palette.gray,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                           ),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Palette.gray),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           focusedBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Colors.black),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           filled: true,
                  //                           fillColor: Palette.white,
                  //                           isDense: true,
                  //                           contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
                  //                         ),
                                          
                  //                         onChanged: (value){
                  //                           controller.signInUserPassword.value = value;
                  //                         },
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )
                  //                 // 회원가입 화면
                  //                 : Column(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: [
                  //                     // 이메일
                  //                     Container(
                  //                       color: Colors.grey,
                  //                       child: TextField(
                  //                         key: const ValueKey(3),
                  //                         keyboardType: TextInputType.emailAddress,
                                    
                  //                         cursorColor: Palette.black,
                  //                         cursorWidth: 2,
                  //                         cursorHeight: 15,
                  //                         autocorrect: false,
                                    
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                         decoration: InputDecoration(
                  //                           hintText: 'E-mail Address',
                  //                           hintStyle: const TextStyle(
                  //                             color: Palette.gray,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                                              
                  //                           ),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Palette.gray),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           focusedBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Colors.black),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           filled: true,
                  //                           fillColor: Palette.white,
                  //                           isDense: true,
                  //                           contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
                  //                         ),
                                          
                  //                         onChanged: (value){
                  //                           controller.signUpUserEmail.value = value;
                  //                         },
                  //                       ),
                  //                     ),
                                          
                  //                     // 비밀번호
                  //                     Container(
                  //                       color: Colors.grey,
                  //                       child: TextField(
                  //                         key: const ValueKey(4),
                  //                         keyboardType: TextInputType.emailAddress,
                                          
                  //                         obscureText: true,
                  //                         cursorColor: Palette.black,
                  //                         cursorWidth: 2,
                  //                         cursorHeight: 15,
                  //                         autocorrect: false,
                                        
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                         decoration: InputDecoration(
                  //                           // contentPadding: const EdgeInsets.only(left: 20),
                  //                           hintText: 'Password',
                  //                           hintStyle: const TextStyle(
                  //                             color: Palette.gray,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                           ),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Palette.gray),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           focusedBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Colors.black),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           filled: true,
                  //                           fillColor: Palette.white,
                  //                           isDense: true,
                  //                           contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
                  //                         ),
                  //                         onChanged: (value){
                  //                           controller.signUpUserPassword.value = value;
                  //                         },
                  //                       ),
                  //                     ),
                                
                  //                     // 비밀번호 체크
                  //                     Container(
                  //                       color: Colors.grey,
                  //                       child: TextField(
                  //                         key: const ValueKey(5),
                  //                         keyboardType: TextInputType.emailAddress,
                  //                         obscureText: true,
                  //                         cursorColor: Palette.black,
                  //                         cursorWidth: 2,
                  //                         cursorHeight: 15,
                  //                         autocorrect: false,
                                        
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                         decoration: InputDecoration(
                  //                           hintText: 'Password Check',
                  //                           hintStyle: const TextStyle(
                  //                             color: Palette.gray,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w400,
                  //                           ),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Palette.gray),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           focusedBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(color: Colors.black),
                  //                             borderRadius: BorderRadius.circular(50)
                  //                           ),
                  //                           filled: true,
                  //                           fillColor: Palette.white,
                  //                           isDense: true,
                  //                           contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
                  //                         ),
                                          
                  //                         onChanged: (value){
                  //                           controller.userPasswordRepeat.value = value;
                  //                         },
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //             ),
                                  
                  //             // // if(isSignin)
                  //             Container(
                  //               height: 100,
                  //               color: Colors.red[200],
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Container(
                  //                     height: 25,
                  //                     color: Colors.blue[300],
                  //                     child: Center(
                  //                       child: Text('ERROR MESSAGE',
                  //                         style: TextStyle(
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w400,
                  //                           color: Colors.red
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   // 버튼
                  //                   InkWell(
                  //                     onTap: () {
                  //                       controller.signIn();
                  //                     },
                  //                     child: Container(
                  //                       margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //                       height: 45,
                  //                       decoration: BoxDecoration(
                  //                         color: Palette.navy,
                  //                         borderRadius: BorderRadius.circular(50)
                  //                         // boxShadow: 
                  //                       ),
                  //                       child: Center(
                  //                         child: Text('Next',
                  //                         style: TextStyle(
                  //                           color: Palette.white,
                  //                           fontWeight: FontWeight.w700,
                  //                           fontSize: 16
                  //                         ),),
                  //                       ), 
                  //                     ),
                  //                   ),
                                    
                  //                   // 회원가입 / 로그인으로 가기 버튼
                  //                   Container(
                  //                     height: 25,
                  //                     color: Colors.red[400],
                  //                       child: GestureDetector(
                  //                         onTap: (){
                  //                           setState(() {
                  //                             isSignin = !isSignin;
                  //                           });
                  //                         },
                  //                         child: Row(
                  //                         mainAxisAlignment: MainAxisAlignment.center,
                  //                         crossAxisAlignment: CrossAxisAlignment.center,
                  //                         children: [
                  //                           Text(
                  //                             isSignin
                  //                             ? 'Don’t you have an account?'
                  //                             : 'Do you have an account?',
                  //                             style: TextStyle(
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w600,
                  //                               color: Palette.middleblack
                  //                             ),
                  //                           ),
                  //                           SizedBox(width: 5),
                  //                           Text(isSignin ?'Sign Up !' :'Sign In !',
                  //                             style: TextStyle(
                  //                               // color: Palette.navy,
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w600,
                  //                               fontStyle: FontStyle.italic
                  //                             ),
                  //                           )
                  //                         ],
                  //                                                             ),
                  //                       ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     // Container(
                  //     //   // margin: EdgeInsets.only(top: 10),
                  //     //   height: 50,
                  //     //   width: 360,
                  //     //   color: Colors.blue.withOpacity(0.5),
                  //     //   child: Center(child: Text('Admob Banner',)),
                  //     // )
                            
                      
                  //   ],
                  // ),
                  // admob
                  // if(!isKeyboardVisible)
                  // Positioned(
                  //   bottom: 0,
                  //   child: AnimatedContainer(
                  //     // margin: EdgeInsets.only(top: 10),
                  //     duration: Duration(milliseconds: 150),
                  //     curve: Curves.easeIn,
                  //     width: 360,
                  //     height: 50,
                  //     // height: isKeyboardVisible ? 0 :50,
                  //     color: Colors.blue.withOpacity(0.5),
                  //     child: Center(child: Text('Admob Banner',)),
                  //   )
                  // )
                ],
              ),

            ),
          ),
        );
      },
    );
  }
}