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
              flex: 4,
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
                                    color: Palette.lightblack
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    key: const ValueKey(1),
                                    keyboardType: TextInputType.emailAddress,
                                    // autofocus: true,
                                    cursorColor: Palette.lightblack,
                                    cursorWidth: 2,
                                    cursorHeight: 15,

                                    style: const TextStyle(
                                      fontSize: 11,
                                      // fontFamily: 'carter'
                                      fontFamily: 'notosans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left: 10),
                                      hintText: 'abc@example.com',
                                      hintStyle: const TextStyle(
                                        color: Palette.gray,
                                        fontSize: 11,
                                        // fontFamily: 'carter'
                                        fontFamily: 'notosans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      filled: true,
                                      fillColor: Palette.lightyellow
                                    ),
                                    
                                    onChanged: (value){},
                                  ),
                                )
                              ],
                            ),
                            isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 10),
                            // 비밀번호 입력 창
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const Text('Password',
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //         fontFamily: 'carter',
                            //         color: Palette.lightblack
                            //       ),
                            //     ),
                            //     Container(
                            //       height: 40,
                            //       // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            //       child: TextField(
                            //         key: const ValueKey(1),
                            //         keyboardType: TextInputType.emailAddress,
                            //         obscureText: true,
                            //         cursorColor: Palette.lightblack,
                            //         cursorWidth: 2,
                            //         cursorHeight: 15,

                            //         style: const TextStyle(
                            //           fontSize: 11,
                            //           fontFamily: 'notosans',
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //         decoration: const InputDecoration(
                            //           hintText: '******',
                            //           hintStyle: TextStyle(
                            //             color: Palette.gray,
                            //             // fontFamily: 'carter',
                            //             fontSize: 11,
                            //             fontFamily: 'notosans',
                            //             fontWeight: FontWeight.w600,
                            //           ),
                            //           enabledBorder: UnderlineInputBorder(
                            //             borderSide: BorderSide(color: Palette.lightblack)
                            //           ),
                            //           focusedBorder: UnderlineInputBorder(
                            //             borderSide: BorderSide(color: Palette.lightblack)
                            //           ),
                            //           contentPadding: EdgeInsets.only(left: 2)
                            //         ),
                                    
                            //         onChanged: (value){},
                            //       ),
                            //     )
                            //   ],
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'carter',
                                    color: Palette.lightblack
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    key: const ValueKey(1),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    cursorColor: Palette.lightblack,
                                    cursorWidth: 2,
                                    cursorHeight: 15,

                                    style: const TextStyle(
                                      fontSize: 11,
                                      // fontFamily: 'carter'
                                      fontFamily: 'notosans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left: 10),
                                      hintText: '******',
                                      hintStyle: const TextStyle(
                                        color: Palette.gray,
                                        fontSize: 11,
                                        // fontFamily: 'carter'
                                        fontFamily: 'notosans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      filled: true,
                                      fillColor: Palette.lightyellow
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
              width: 235,
              height: 40,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Palette.lightblack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onHover: (hover){
                  // setState(() {
                    // hover
                    // ? nextBtn='Next' 
                    // : nextBtn='Sign In !';
                  // });
                },
                onPressed: (){

                }, 
                child: Text('Go !',
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'carter'
                  ),
                )
              )
            ),
            
          ],
        ); 
      }
    );
  }
}