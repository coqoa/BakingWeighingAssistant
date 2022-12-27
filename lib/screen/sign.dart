// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/sign_controller.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
    return Scaffold(
      // backgroundColor: Color.fromARGB(250, 235, 235, 235),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) { 
          return Center(
              child: Container(
                height: GetPlatform.isMobile? boxHeight: 637, // 웹 / 모바일 height 분기
                width: GetPlatform.isMobile ? boxWidth : 375, // 웹 / 모바일 width 분기
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(15),
                  // 컨테이너 테두리 선
                  // border: Border.all(
                  //   color:  GetPlatform.isMobile?Colors.transparent : Palette.gray,
                  //   width: 2.0,
                  // ),
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
                padding: EdgeInsets.only(top: statusBarHeight),
                
    
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 상단 로고
                    Positioned(
                      top: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        curve: Curves.linear,
                        width: 300,
                        height: isKeyboardVisible ? 0 :350,
                        child: Container(
                          // color: Colors.red.withOpacity(0.5),
                          child: Center(
                            child: 
                            // TITLE
                            Stack(
                              children: <Widget>[
                                // 
                                Text(
                                  'Gramming',
                                  style: TextStyle(
                                    fontFamily: 'carter',
                                    fontSize: 50,
                                    // 텍스트 테두리 선
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 4
                                      ..color = Colors.black,
                                    // 자간
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  'Gramming',
                                  style: TextStyle(
                                    fontFamily: 'carter',
                                    fontSize: 50,
                                    color: Palette.white,
                                    letterSpacing: 2,
                                    // TODO 텍스트 그림자 꼭 필요한가/.
                                    shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(6.0, 2.0),
                                        blurRadius: 0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                        )
                      ),
    
                    ),
                    
                    // 로그인 / 회원가입 + 애드몹 섹션
                    Positioned(
                      bottom: 0,
                      child: Container(
                        // width: 375, // web이라면?
                        width: boxWidth, // TODO 디자인 체크 필요 : boxWidth 변수자체에 initState할때 값을 지정? (웹 / 모바일에 따라), 이 아래에 width, height 모두 변경해야할 필요성?
                        height: isKeyboardVisible 
                        ? MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom
                        : 365, // fix ? // TODO 삭제하거나 수정해도될지?
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            // SIGN BOX
                            Container(
                              width: 214,
                              height: 300,
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
                                        height: 200,
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
                                    width: 300,
                                    height: 100,
                                    // color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // ERROR MESSAGE 
                                        Obx(()=>
                                          Container(
                                            height: 15,
                                            // color: Colors.blue[300],
                                            child: Center(
                                              child: Text(controller.validationResult.value,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red
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
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Palette.black,
                                              // borderRadius: BorderRadius.circular(50)
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(isSignin ?'Sign In' :'Sign Up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20
                                              ),),
                                            ), 
                                          ),
                                        ),
    
                                        // SIGN PAGE TOGGLE
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              isSignin = !isSignin;
                                              controller.initValidation();
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            margin: EdgeInsets.only(top: 5),
                                            // color: Colors.red[400],
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  isSignin ? 'Don’t you have an account? ' : 'Do you have an account? ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Palette.middleblack
                                                  ),
                                                ),
                                                Text(isSignin ?'Sign Up !' :'Sign In !',
                                                  style: TextStyle(
                                                    color: Palette.black,
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
    
                            // BOTTOM ADS
                            GetPlatform.isMobile 
                            ? Container(
                              // width: 375,
                              width: boxWidth,
                              height: 30,
                              color: Colors.black54,
                            )
                            : SizedBox()
                          ],
                        ),
                      ),
                    )
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
          fontWeight: FontWeight.bold,
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
        // print(widget.nextEvent.toString());
      },
    );
  }
}