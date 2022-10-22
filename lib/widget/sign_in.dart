import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          children: [
            !isKeyboardVisible ? const SizedBox(height: 20) : const SizedBox(height: 0),
            // 텍스트 폼 필드
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 이메일 입력 창
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('E-Mail Address',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'carter',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 40,
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
                                const Text('Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'carter',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  height: 40,
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
                          ],
                        ),
                      ],
                    ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // 버튼
            Container(
              width: 230,
              height: 40,
              decoration: BoxDecoration(
                color: Palette.lightblack,
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Text('Sign In',
                  style: TextStyle(
                    fontSize: 23,
                    color: Palette.white
                  ),
                )
              ),
            ),
          ],
        ); 
      }
    );
  }
}