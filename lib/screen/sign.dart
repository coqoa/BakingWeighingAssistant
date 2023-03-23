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
  late double statusBarHeight = MediaQuery.of(context).padding.top; // 상단 바 크기
  final SignController controller = SignController(); 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) { 
          return SafeArea(
            child: Stack(
              children: [
                // header:
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                    width: 300.w,
                    height: isKeyboardVisible ? 0 : 370.h,
                    child: Center(
                      child: 
                      // section: Logo Image Section
                      Stack(
                        children: <Widget>[
                          Text(
                            'Gramming',
                            style: TextStyle(
                              fontFamily: 'carter',
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                              // 텍스트 테두리 선
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = Colors.black,
                              letterSpacing: 5,
                            ),
                          ),
                          Text(
                            'Gramming',
                            style: TextStyle(
                              fontFamily: 'carter',
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                              color: Palette.white,
                              letterSpacing: 5,
                              shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(4.0, 3.0),
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
                
                // main:
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 360.w,
                    height: 520.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // section: Sign Section
                        Container(
                          width: 244.w,
                          height: 420.h,
                          decoration: BoxDecoration(
                            color: Palette.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                    
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // info: 텍스트 필드
                              Column(
                                children: [
                                  SizedBox(
                                    height: 220.h,
                                    child: isSignin 
                                    // div: Sign in Box
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
                    
                                    // div: Sign up Box
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
                              
                              // contents_footer: 
                              SizedBox(
                                width: 300.w,
                                height: 170.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // div: Error Message Section
                                    Obx(()=>
                                      SizedBox(
                                        height: 25.h,
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

                                    // div: Submit Button Section
                                    InkWell(
                                      onTap: () {
                                        isSignin ? controller.signIn('SignIn') : controller.signUp('SignUp');
                                      },
                                      child: Container(
                                        width: 214.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          color: Palette.black,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(isSignin ?'Log in' :'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18
                                          ),),
                                        ), 
                                      ),
                                    ),

                                    SizedBox(height: 7.h,),
                    
                                    // div: Page Toggle Section
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          isSignin = !isSignin;
                                          controller.initValidation();
                                        });
                                      },
                                      child: SizedBox(
                                        height: 25.h,
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
                                            Text(isSignin ?'Join us' :'Log in',
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
                                    ),
                                    SizedBox(height: 5.h,),
                                    // div: anonymous account
                                    InkWell(
                                      onTap: (){
                                        controller.startAnonymous();
                                      },
                                      child: SizedBox(
                                        height: 25.h,
                                        child: Text(
                                          'or Start with an anonymous account',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Palette.gray
                                          ),
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
              ],
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
      key: widget.valueKey, 
      keyboardType: TextInputType.emailAddress,
      obscureText: widget.obscureText,
    
      cursorColor: Palette.black,
      cursorWidth: 2,
      cursorHeight: 20,
      autocorrect: false, 

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