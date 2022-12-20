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
  late double statusBarHeight = MediaQuery.of(context).padding.top; // 상단 바
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  double bottomAdHeight = 50;

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
              color: Colors.white,
              padding: EdgeInsets.only(top: statusBarHeight),
              // color: Colors.amber,
              

              child: Stack(
                alignment: Alignment.center,
                children: [
                  // LOGO
                  Positioned(
                    top: 0,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        curve: Curves.linear,
                        width: 300,
                        height: isKeyboardVisible ? 0 :boxHeight-365,
                        child: Container(
                          color: Colors.red.withOpacity(0.5),
                            child: Center(
                              child: isKeyboardVisible 
                                ? Text('',) 
                                : Text('이미지')
                            ),
                          )
                      ),

                  ),
                  
                  // SIGN SECTION 
                  Positioned(
                    bottom: 0,
                    child: Container(
                      // width: 375, // web이라면?
                      width: boxWidth,
                      height: isKeyboardVisible 
                      ? MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom
                      : 365, // fix ?
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          // SIGN BOX
                          Container(
                            // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            // margin: EdgeInsets.fromLTRB(30 , 0, 30, 0),
                            // color: Colors.orange,
                            // height: 365-50,
                            
                            // SIGN SHELL
                            child: Container(
                              width: 214,
                              decoration: BoxDecoration(
                                color: Palette.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.16),
                                //     spreadRadius: 1,
                                //     blurRadius: 20,
                                //     offset: Offset(3, 16), // changes position of shadow
                                //   ),
                                // ],
                                // borderRadius: BorderRadius.circular(20),
                                borderRadius: BorderRadius.circular(5),
                              ),


                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // TITLE FIELD
                                  Container(
                                    width: 300,
                                    height: 60,
                                    padding: EdgeInsets.only(left: 25),
                                    // color: Colors.red.withOpacity(0.5),
                                    child:  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(isSignin? 'Sign In ${MediaQuery.of(context).viewInsets.bottom}' : 'Sign Up',
                                        style: TextStyle(
                                          fontFamily: 'nanumSquareRound',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 30
                                        )
                                      ),
                                    ),
                                  ),

                                  // TEXT FIELD
                                  Container(
                                    width: 300,
                                    
                                    // color: Colors.red[200],
                                    // padding: EdgeInsets.only(left: 15,right: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        
                                        Container(
                                          height: 160,
                                          child:  
                                            isSignin 
                                            // SIGN IN
                                            ? Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SignTextField(
                                                  type: controller.signInUserEmail.value,
                                                  valueKey: const ValueKey(1), 
                                                  obscureText: false, 
                                                  hintText: 'E-Mail Address', 
                                                ),
                                                SignTextField(
                                                  type: controller.signInUserPassword.value,
                                                  valueKey: const ValueKey(2), 
                                                  obscureText: true, 
                                                  hintText: 'Password', 
                                                ),
                                                
                                              ],
                                            )

                                            // SIGN UP
                                            : Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SignTextField(
                                                  type: controller.signUpUserEmail.value,
                                                  valueKey: const ValueKey(3), 
                                                  obscureText: false, 
                                                  hintText: 'E-Mail Address', 
                                                ),
                                                SignTextField(
                                                  type: controller.signUpUserPassword.value,
                                                  valueKey: const ValueKey(4), 
                                                  obscureText: true, 
                                                  hintText: 'Password', 
                                                ),
                                                SignTextField(
                                                  type: controller.signUpUserPasswordRepeat.value,
                                                  valueKey: const ValueKey(5), 
                                                  obscureText: true, 
                                                  hintText: 'Password Repeat', 
                                                ),
                                              ],
                                            ),
                                        ),
                                       
                                        // ERROR MESSAGE => 위로 올리자
                                        Container(
                                          height: 20,
                                          // color: Colors.blue[300],
                                          child: Center(
                                            child: Text('ERROR MESSAGE',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.red
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                  
                                  // BUTTON FIELD
                                  Container(
                                    width: 300,
                                    height: 75,
                                    padding: EdgeInsets.only(top: 5),
                                    // color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // NEXT BUTTON
                                        InkWell(
                                          onTap: () {
                                            controller.signIn();
                                          },
                                          child: Container(
                                            // margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Palette.navy,
                                              // borderRadius: BorderRadius.circular(50)
                                              borderRadius: BorderRadius.circular(5)
                                              // boxShadow: 
                                            ),
                                            child: Center(
                                              child: Text(isSignin ?'Sign In' :'Sign Up',
                                              style: TextStyle(
                                                fontFamily: 'Carter',
                                                color: Palette.white,
                                                // fontWeight: FontWeight.w700,
                                                fontSize: 16
                                              ),),
                                            ), 
                                          ),
                                        ),

                                        // SIGN PAGE TOGGLE
                                        Container(
                                          height: 30,
                                          // color: Colors.red[400],
                                            child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  isSignin = !isSignin;
                                                });
                                              },
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
                                                  Text(isSignin ?'Sign Up !' :'Sign In !',
                                                    style: TextStyle(
                                                      // color: Palette.navy,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FontStyle.italic
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                        )
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // BOTTOM ADS
                          Container(
                            // width: 375,
                            width: boxWidth,
                            height: 30,
                            color: Colors.black54,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SignTextField extends StatefulWidget {
  SignTextField({super.key, required this.valueKey, required this.obscureText, required this.hintText, required this.type});

  final ValueKey valueKey;
  final bool obscureText;
  final String hintText;
  late final dynamic type;

  @override
  State<SignTextField> createState() => _SignTextFieldState();
}

class _SignTextFieldState extends State<SignTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      // padding: EdgeInsets.only(left: 20, right: 20),
      width: 214,
      child: TextField(
        key: widget.valueKey, // 
        keyboardType: TextInputType.emailAddress,
        obscureText: widget.obscureText,
      
        cursorColor: Palette.black,
        cursorWidth: 2,
        cursorHeight: 15,
        autocorrect: false, // 
      
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Palette.gray,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Palette.gray),
          //   borderRadius: BorderRadius.circular(50)
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.black),
          //   borderRadius: BorderRadius.circular(50)
          // ),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
          filled: true,
          fillColor: Palette.white,
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(5,15,0,5)
        ),
        
        onChanged: (value){
          setState(() {
            widget.type = value;
          });
          // controller.signInUserEmail.value = value;
        },
      ),
    );
  }
}