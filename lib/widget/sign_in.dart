import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authentication = FirebaseAuth.instance;
  late double boxHeight = MediaQuery.of(context).size.height;
  

  final _formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  String fontFamily = "NotoSansRegular";

  void signinBtnClick()async{
    print(userEmail);
    print(userPassword);
    // try{
    //   final signinBtnClicked = await _authentication.signInWithEmailAndPassword(
    //     email: userEmail, 
    //     password: userPassword
    //   );
    //   if(signinBtnClicked.user != null){
    //     Get.to(Recipe());
    //   }
    // }catch(e){
    //   print(e);
    // }
    // e.message를 잡기 위해선 아래와 같은 형식으로 
    // 참고 https://github.com/firebase/snippets-web/blob/36740fb2c39383621c0c0a948236e9eab8a71516/snippets/auth-next/email/auth_signin_password.js#L8-L20
    final signinBtnClicked = await _authentication.signInWithEmailAndPassword(
      email: userEmail, 
      password: userPassword
    ).then((value) {
      if(value.user != null){
        // print(value.user);
        Get.to(transition: Transition.rightToLeft, Recipe());
        
      }
    }).catchError((e){
      print(e);
      print(e.message);
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext , bool isKeyboardVisible) {
        return Column(  
          children: [
            !isKeyboardVisible ? const SizedBox(height: 10) : const SizedBox(height: 0),
            // 텍스트 폼 필드
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 이메일 입력 창
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
                            // 비밀번호
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
                                const SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: TextField(
                                    key: const ValueKey(2),
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
                onHover: (hover){
},
                onPressed: (){
                  signinBtnClick();
                }, 
                child: const Text('Go !',
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