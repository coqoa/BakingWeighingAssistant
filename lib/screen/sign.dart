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
          // backgroundColor: Palette.backgroundColor,
          backgroundColor: Color.fromARGB(250, 235, 235, 235),
          body: Center(
            child: Container(
              height: GetPlatform.isMobile? boxHeight: 667, // 웹이면 변경
              width: GetPlatform.isMobile ? boxWidth : 375, // 웹이면 변경
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(
                //   color:  GetPlatform.isMobile?Colors.transparent : Palette.gray,
                //   width: 2.0,
                // ),
                // color: Colors.amber,
                color: Palette.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.03),
                    spreadRadius: 18,
                    blurRadius: 18,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(top: statusBarHeight),
              

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
                        height: isKeyboardVisible ? 0 :350,
                        child: Container(
                          // color: Colors.red.withOpacity(0.5),
                            child: Center(
                              child: 
                                // TITLE
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      'Gramming',
                                      style: TextStyle(
                                        fontFamily: 'carter',
                                        fontSize: 50,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 4
                                          ..color = Colors.black,
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
                                          print('isSignin');
                                          print(isSignin);
                                          print('isSignin');
                                          isSignin ? controller.signIn('SignIn') : controller.signUp('SignUp');
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Palette.black,
                                            // borderRadius: BorderRadius.circular(50)
                                            borderRadius: BorderRadius.circular(5)
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
          ),
        );
      },
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
          // next 스코프 이벤트
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