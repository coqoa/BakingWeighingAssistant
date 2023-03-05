// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Sign extends StatefulWidget {
  Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool isSignin = true;
  bool isBtnHovered = false;
  late double statusBarHeight = MediaQuery.of(context).padding.top; // 상단 바

  final SignController controller = SignController(); 

  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) { 
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.circular(15),
                // 그림자
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.03),
                    spreadRadius: 18,
                    blurRadius: 18,
                    offset: Offset(1, 1), 
                  ),
                ],
              ),
              
              child: Stack(
                children: [
                  // 상단 로고
                  Align(
                    alignment: Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      width: 300.w,
                      height: isKeyboardVisible ? 0 : 370.h,
                      // color: Colors.red[100],
                      child: Center(
                        child: 
                        // TITLE
                        Stack(
                          children: <Widget>[
                            Text(
                              // 'GRAMMING',
                              'Gramming',
                              style: TextStyle(
                                // fontFamily: 'carter',
                                fontWeight: FontWeight.w900,
                                fontSize: 50,
                                // 텍스트 테두리 선
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.black,
                                // 자간
                                letterSpacing: 4,
                              ),
                            ),
                            Text(
                              // 'GRAMMING',
                              'Gramming',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 50,
                                color: Palette.white,
                                letterSpacing: 4,
                                // TODO 텍스트 그림자 꼭 필요한가/.
                                shadows: const <Shadow>[
                                  Shadow(
                                    offset: Offset(5.0, 3.0),
                                    blurRadius: 0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      )
                    ),
                  ),
                  
                  // 로그인 / 회원가입 + 애드몹 섹션
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 360.w, // TODO 디자인 체크 필요 : boxWidth 변수자체에 initState할때 값을 지정? (웹 / 모바일에 따라), 이 아래에 width, height 모두 변경해야할 필요성?
                      height: 570.h,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SIGN BOX
                          Container(
                            width: 244.w,
                            height: 430.h,
                            decoration: BoxDecoration(
                              color: Palette.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                      
                      
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // TEXT FIELD
                                Column(
                                  children: [
                                    Container(
                                      height: 70.h,
                                      // color: Colors.cyan,
                                      child: Center(
                                        child: Text(isSignin ?'Sign In' :'New Account',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 220.h,
                                      // color: Colors.orange,
                                      child: isSignin 
                                      // SIGN IN
                                      ? Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SignTextField(
                                            controller: controller,
                                            valueKey: const ValueKey(1), 
                                            obscureText: false, 
                                            hintText: 'E-Mail Address', 
                                            type: 'userEmail',
                                            textInputAction: TextInputAction.next,
                                            nextEvent: true,
                                            sign: isSignin,
                                          ),
                                          SignTextField(
                                            controller: controller,
                                            valueKey: const ValueKey(2), 
                                            obscureText: true, 
                                            hintText: 'Password', 
                                            type: 'userPassword',
                                            textInputAction: TextInputAction.done,
                                            nextEvent: false,
                                            sign: isSignin,
                                          ),
                                        ],
                                      )
                      
                                      // SIGN UP
                                      : Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SignTextField(
                                            controller: controller,
                                            valueKey: const ValueKey(3), 
                                            obscureText: false, 
                                            hintText: 'E-Mail Address', 
                                            type: 'userEmail',
                                            textInputAction: TextInputAction.next,
                                            nextEvent: true,
                                            sign: isSignin,
                                          ),
                                          SignTextField(
                                            controller: controller,
                                            valueKey: const ValueKey(4), 
                                            obscureText: true, 
                                            hintText: 'Password', 
                                            type: 'userPassword',
                                            textInputAction: TextInputAction.next,
                                            nextEvent: true,
                                            sign: isSignin,
                                          ),
                                          SignTextField(
                                            controller: controller,
                                            valueKey: const ValueKey(5), 
                                            obscureText: true, 
                                            hintText: 'Password Repeat', 
                                            type: 'userPasswordRepeat',
                                            textInputAction: TextInputAction.done,
                                            nextEvent: false,
                                            sign: isSignin,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // BUTTON FIELD
                                Container(
                                  width: 300.w,
                                  height: 140.h,
                                  // color: Colors.blue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      // ERROR MESSAGE 
                                      Obx(()=>
                                        Container(
                                          height: 25.h,
                                          // color: Colors.blue[300],
                                          child: Center(
                                            child: Text(controller.validationResult.value,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                color: Palette.red
                                              ),
                                            ),
                                          ),
                                        )
                                      ),
                                      SizedBox(height: 10,),
                                      // NEXT BUTTON
                                      InkWell(
                                        onTap: () {
                                          isSignin ? controller.signIn('SignIn') : controller.signUp('SignUp');
                                        },
                                        child: Container(
                                          width: 214.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                            color: Palette.black,
                                            // borderRadius: BorderRadius.circular(50)
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(isSignin ?'Next' :'Submit',
                                            // child: Text('Next',
                                            style: TextStyle(
                                              color: Colors.white,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 19
                                            ),),
                                          ), 
                                        ),
                                      ),
                                      SizedBox(height: 5.h,),
                      
                                      // SIGN PAGE TOGGLE
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            isSignin = !isSignin;
                                            controller.initValidation();
                                          });
                                        },
                                        child: Container(
                                          height: 25.h,
                                          // color: Colors.red[400],
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                isSignin ? 'Don’t you have an account? ' : 'Do you have an account? ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: Palette.middleblack
                                                ),
                                              ),
                                              Text(isSignin ?'Sign Up !' :'Sign In !',
                                                style: TextStyle(
                                                  color: Palette.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900,
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
                      
                        ],
                      ),
                    ),
                  ),
                  // // BOTTOM ADS
                  // GetPlatform.isMobile 
                  // ? Container(
                  //   // width: 375,
                  //   width: 360.w,
                  //   height: 45.h,
                  //   color: Colors.black54,
                  // )
                  // : SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignTextField extends StatefulWidget {
  SignTextField({
    super.key, 
    required this.controller, 
    required this.valueKey, 
    required this.obscureText, 
    required this.hintText, 
    required this.type, 
    required this.textInputAction, 
    required this.nextEvent, 
    required this.sign
  });

  final SignController controller;
 
  final ValueKey valueKey;
  final bool obscureText;
  final String hintText;
  late String type;
  final TextInputAction textInputAction;
  final bool nextEvent;
  final bool sign;
  @override
  State<SignTextField> createState() => _SignTextFieldState();
}

class _SignTextFieldState extends State<SignTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.valueKey, // 
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.obscureText,
    
      cursorColor: Palette.black,
      cursorWidth: 2,
      cursorHeight: 20,
      autocorrect: false, // 

      textInputAction: widget.textInputAction,
    
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Palette.gray,
          fontSize: 18,
          fontWeight: FontWeight.w200,
        ),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
        filled: true,
        fillColor: Palette.white,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5,15,0,5)
      ),
      
      onChanged: (value){
          widget.controller.textFieldChanged(widget.type, value);
      },
      onSubmitted: (_){
        if(widget.nextEvent){
          // next Scope 이벤트
        }else{
          if(widget.sign){
            widget.controller.signIn('SignIn');
          }else{
            widget.controller.signUp('SignUp');
          }
        }
      },
    );
  }
}