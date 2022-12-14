// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//        child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedContainer(
//               duration: Duration(milliseconds: 250),
//               curve: Curves.easeIn,
//               margin: EdgeInsets.only(top: isKeyboardVisible? 0 : 160),
//               padding: EdgeInsets.fromLTRB(0,10,0,10),
//               child: Container(
//               height: 365,
//                 // margin: EdgeInsets.only(top: 10),
//                 padding: EdgeInsets.fromLTRB(10,0,10,0),
//                 decoration: BoxDecoration(
//                   color: Palette.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.16),
//                       spreadRadius: 1,
//                       blurRadius: 20,
//                       offset: Offset(3, 16), // changes position of shadow
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
                
//                 // -- 여기까지 221214
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // 타이틀
//                     Container(
//                       height: 55,
//                       color: Colors.green,
//                       padding: EdgeInsets.only(left: 20, right: 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Title    
                         
//                         ],
//                       )
//                     ),
   
//                     // 텍스트폼필드
//                     Container(
//                       padding: EdgeInsets.only(left: 20, right: 20),
//                       height: 210,
//                       color: Colors.blue,
//                       child: 
                                
//                       isSignin
//                       // 로그인 화면
//                       ? Column(  
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             // 텍스트 폼 필드
//                             // TODO SIGNIN
//                             // 이메일
//                             Container(
//                               // height: 50,
//                               color: Colors.grey,
//                               child: TextField(
//                                 key: const ValueKey(1),
//                                 keyboardType: TextInputType.emailAddress,
                              
//                                 cursorColor: Palette.black,
//                                 cursorWidth: 2,
//                                 cursorHeight: 15,
//                                 autocorrect: false,
                              
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 // textAlign: TextAlign.center,
//                                 decoration: InputDecoration(
//                                   // contentPadding: const EdgeInsets.only(left: 20),
//                                   hintText: 'E-mail Address',
//                                   hintStyle: const TextStyle(
//                                       color: Palette.gray,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Palette.gray),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   filled: true,
//                                   fillColor: Palette.white,
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
//                                 ),
                                
//                                 onChanged: (value){
//                                   controller.signInUserEmail.value = value;
//                                 },
//                               ),
//                             ),
                      
//                             // 비밀번호
//                             Container(
//                               color: Colors.grey,
//                               child: TextField(
//                                 key: const ValueKey(2),
//                                 keyboardType: TextInputType.emailAddress,
                                
//                                 obscureText: true,
                                
//                                 cursorColor: Palette.black,
//                                 cursorWidth: 2,
//                                 cursorHeight: 15,
//                                 autocorrect: false,
                              
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 decoration: InputDecoration(
//                                   // contentPadding: const EdgeInsets.only(left: 20),
//                                   hintText: 'Password',
//                                   hintStyle: const TextStyle(
//                                     color: Palette.gray,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Palette.gray),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   filled: true,
//                                   fillColor: Palette.white,
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
//                                 ),
                                
//                                 onChanged: (value){
//                                   controller.signInUserPassword.value = value;
//                                 },
//                               ),
//                             ),
//                           ],
//                         )
//                         // 회원가입 화면
//                         : Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             // 이메일
//                             Container(
//                               color: Colors.grey,
//                               child: TextField(
//                                 key: const ValueKey(3),
//                                 keyboardType: TextInputType.emailAddress,
                          
//                                 cursorColor: Palette.black,
//                                 cursorWidth: 2,
//                                 cursorHeight: 15,
//                                 autocorrect: false,
                          
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'E-mail Address',
//                                   hintStyle: const TextStyle(
//                                     color: Palette.gray,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
                                    
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Palette.gray),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   filled: true,
//                                   fillColor: Palette.white,
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
//                                 ),
                                
//                                 onChanged: (value){
//                                   controller.signUpUserEmail.value = value;
//                                 },
//                               ),
//                             ),
                                
//                             // 비밀번호
//                             Container(
//                               color: Colors.grey,
//                               child: TextField(
//                                 key: const ValueKey(4),
//                                 keyboardType: TextInputType.emailAddress,
                                
//                                 obscureText: true,
//                                 cursorColor: Palette.black,
//                                 cursorWidth: 2,
//                                 cursorHeight: 15,
//                                 autocorrect: false,
                              
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 decoration: InputDecoration(
//                                   // contentPadding: const EdgeInsets.only(left: 20),
//                                   hintText: 'Password',
//                                   hintStyle: const TextStyle(
//                                     color: Palette.gray,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Palette.gray),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   filled: true,
//                                   fillColor: Palette.white,
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
//                                 ),
//                                 onChanged: (value){
//                                   controller.signUpUserPassword.value = value;
//                                 },
//                               ),
//                             ),
                      
//                             // 비밀번호 체크
//                             Container(
//                               color: Colors.grey,
//                               child: TextField(
//                                 key: const ValueKey(5),
//                                 keyboardType: TextInputType.emailAddress,
//                                 obscureText: true,
//                                 cursorColor: Palette.black,
//                                 cursorWidth: 2,
//                                 cursorHeight: 15,
//                                 autocorrect: false,
                              
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'Password Check',
//                                   hintStyle: const TextStyle(
//                                     color: Palette.gray,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Palette.gray),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: const BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(50)
//                                   ),
//                                   filled: true,
//                                   fillColor: Palette.white,
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.fromLTRB(20,13,13,13)
//                                 ),
                                
//                                 onChanged: (value){
//                                   controller.userPasswordRepeat.value = value;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                     ),
                        
//                     // // if(isSignin)
//                     Container(
//                       height: 100,
//                       color: Colors.red[200],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             height: 25,
//                             color: Colors.blue[300],
//                             child: Center(
//                               child: Text('ERROR MESSAGE',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.red
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // 버튼
//                           InkWell(
//                             onTap: () {
//                               controller.signIn();
//                             },
//                             child: Container(
//                               margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 color: Palette.navy,
//                                 borderRadius: BorderRadius.circular(50)
//                                 // boxShadow: 
//                               ),
//                               child: Center(
//                                 child: Text('Next',
//                                 style: TextStyle(
//                                   color: Palette.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 16
//                                 ),),
//                               ), 
//                             ),
//                           ),
                          
//                           // 회원가입 / 로그인으로 가기 버튼
//                           Container(
//                             height: 25,
//                             color: Colors.red[400],
//                               child: GestureDetector(
//                                 onTap: (){
//                                   setState(() {
//                                     isSignin = !isSignin;
//                                   });
//                                 },
//                                 child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     isSignin
//                                     ? 'Don’t you have an account?'
//                                     : 'Do you have an account?',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: Palette.middleblack
//                                     ),
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(isSignin ?'Sign Up !' :'Sign In !',
//                                     style: TextStyle(
//                                       // color: Palette.navy,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       fontStyle: FontStyle.italic
//                                     ),
//                                   )
//                                 ],
//                                                                     ),
//                               ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Container(
//             //   // margin: EdgeInsets.only(top: 10),
//             //   height: 50,
//             //   width: 360,
//             //   color: Colors.blue.withOpacity(0.5),
//             //   child: Center(child: Text('Admob Banner',)),
//             // )
                  
            
//           ],
//         ),
//         admob
//         if(!isKeyboardVisible)
//         Positioned(
//           bottom: 0,
//           child: AnimatedContainer(
//             // margin: EdgeInsets.only(top: 10),
//             duration: Duration(milliseconds: 150),
//             curve: Curves.easeIn,
//             width: 360,
//             height: 50,
//             // height: isKeyboardVisible ? 0 :50,
//             color: Colors.blue.withOpacity(0.5),
//             child: Center(child: Text('Admob Banner',)),
//           )
//         )



//     );
//   }
// }