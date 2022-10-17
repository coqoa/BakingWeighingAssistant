import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  late double boxHeight = MediaQuery.of(context).size.height;

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  String fontFamily = "NotoSansRegular";
  
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            !isKeyboardVisible ? const SizedBox(height: 20) : const SizedBox(height: 0),

            // 텍스트 폼 필드
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20,10,20,0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이메일 입력 창
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Image.asset("assets/images/email-label.png"),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Palette.lightyellow,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                key: const ValueKey(1),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Palette.lightblack,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Palette.lightblack
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value){},
                              ),
                            ),
                          ],
                        ),
                        isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 20),

                        // 비밀번호 입력 창
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Image.asset("assets/images/password-label.png"),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Palette.lightyellow,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                key: const ValueKey(2),
                                obscureText: true,
                                cursorColor: Palette.lightblack,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent
                                    ),
                                    // borderRadius: BorderRadius.circular(10)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Palette.lightblack
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value){},
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        
                        // 버튼
                        Container(
                          height: 50,
                          child: Image.asset("assets/images/signin-btn.png"),
                        ),
                      ],
                    ),
                ),
              ),
            ),
          ],
        ); 
      }
    );
  }
}