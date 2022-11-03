import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _authentication = FirebaseAuth.instance;
  String authErrorMsg = '';
  late double boxHeight = MediaQuery.of(context).size.height;

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  String userPasswordRepeat = '';
  // String fontFamily = "NotoSansRegular";
  
  void signupBtnClick()async{
    print(userEmail);
    print(userPassword);
    print(userPasswordRepeat);

    // 회원가입검증
    try{
      final newUser = await _authentication.createUserWithEmailAndPassword(
        email: userEmail, 
        password: userPassword
      );
      if(newUser.user != null){
        Get.to(()=>Recipe());
      }
    }catch(e){
      print(e);
      setState(() {
        authErrorMsg = e.toString();
      });
      Get.snackbar(
        authErrorMsg, 
        '',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 1500),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
        return Column(  
          children: [
            !isKeyboardVisible ? const SizedBox(height: 20) : const SizedBox(height: 0),
            // 텍스트 폼 필드
            Expanded(
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
                                    color: Palette.middleblack
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
                                    cursorColor: Palette.middleblack,
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    autocorrect: false,

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
                                    
                                    onChanged: (value){
                                      userEmail = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                            isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 10),

                            // 패스워드 입력창
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'carter',
                                    color: Palette.middleblack
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    key: const ValueKey(4),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    cursorColor: Palette.middleblack,
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    autocorrect: false,

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
                                    
                                    onChanged: (value){
                                      userPassword = value;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 10),

                            // 패스워드 체크 입력창
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password Repeat',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'carter',
                                    color: Palette.middleblack
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    key: const ValueKey(5),
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    cursorColor: Palette.middleblack,
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    autocorrect: false,

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
                                    
                                    onChanged: (value){
                                      userPasswordRepeat = value;
                                    },
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
            const SizedBox(height: 10,),
            // 버튼
            SizedBox(
              width: 235,
              height: 40,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onHover: (hover){},
                onPressed: (){
                  signupBtnClick();
                }, 
                child: const Text('Next !',
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