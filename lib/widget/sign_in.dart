import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: 100,
      color: Colors.red[200],
      child: Column(
        children: [
          // 탭
          Container(
            height: 100,
            color: Colors.green[200],
            child: Text('aaaaAAasdA',
            style: TextStyle(fontFamily: 'Raleway'),)
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      height: 75,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 300,
                      height: 75,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 300,
                      height: 55,
                      color: Colors.grey,
                    )
                  ],
                ),
            ),
          ),
          
          // // 상단 탭
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // TextButton(
          //       //   onPressed: (){

          //       //   }, 
          //       //   child: Text('asd')
          //       // ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text('Sign In',
          //             style: TextStyle(
          //               fontFamily: fontFamily,
          //               fontSize: 30,
          //               color: Palette.black,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           Container(
          //             width: 100,
          //             height: 3,
          //             color: Colors.black,
          //           )
          //         ],
          //       ),
          //       SizedBox(width: 50),
          //       TextButton(
          //         onPressed: (){
          //           print('asdasdasd');
          //         }, 
          //         child: Text('Sign up',
          //           style: TextStyle(
          //             fontFamily: fontFamily,
          //             fontSize: 30,
          //             color: Palette.lightgray,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   )
          // ),
          // SizedBox(height: 20),
          // // 텍스트폼필드
          // Expanded(
          //   flex: 4,
          //   child: Form(
          //     key: _formKey,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           height: 100,
          //           color: Colors.red,
          //         ),
          //         // Container(
          //         //   alignment: Alignment.centerLeft,
          //         //   child: Text('E-Mail Address',
          //         //     style: TextStyle(
          //         //       fontSize: 18,
          //         //       fontWeight: FontWeight.bold
          //         //     ),
          //         //   ),
          //         // ),

          //         // Container(
          //         //   decoration: BoxDecoration(
          //         //     borderRadius: BorderRadius.circular(15),
          //         //     color: Palette.lightyellow
          //         //   ),
          //         //   child: TextFormField(
          //         //     keyboardType: TextInputType.emailAddress,
          //         //     key: const ValueKey(1),
          //         //     decoration: const InputDecoration(
          //         //       enabledBorder: OutlineInputBorder(
          //         //         borderSide: BorderSide(color: Colors.transparent),
          //         //       ),
          //         //       focusedBorder: OutlineInputBorder(
          //         //         borderSide: BorderSide(color: Colors.transparent),
          //         //       ),
          //         //       hintText: 'E-Mail',
          //         //       hintStyle: TextStyle(
          //         //         fontSize: 14,
          //         //         color: Palette.lightgray
          //         //       ),
          //         //       // contentPadding: EdgeInsets.fromLTRB(10, 25, 10, 25)
          //         //     ),
          //         //     onChanged: (value){
          //         //       userEmail = value;
          //         //       print(userEmail);
          //         //     },
          //         //   ),
          //         // ),
          //         SizedBox(
          //           height: 20,
          //           // child: Text(loginValidator),
          //         ),
          //         Container(
          //           height: 100,
          //           color: Colors.blue,
          //         ),
          //         // TextFormField(
          //         //   key: const ValueKey(2),
          //         //   validator: (value){
          //         //     // 유효성검사
          //         //     if(value!.isEmpty || value.length < 6){
          //         //       return 'Password must be at least 7 characters long';
          //         //     }
          //         //     return null;
          //         //   },
          //         //   onSaved: (value){
          //         //     userPassword = value!;
          //         //   },
          //         //   onChanged: (value){
          //         //     userPassword = value;
          //         //   },
          //         //   obscureText: true,
          //         //   decoration: InputDecoration(
          //         //     prefixIcon: Icon(
          //         //       Icons.lock,
          //         //       color: Colors.red
          //         //     ),
          //         //     // enabledBorder: OutlineInputBorder(
          //         //     //   borderSide: BorderSide(
          //         //     //     color: Palette.textColor1
          //         //     //   ),
          //         //     //   borderRadius: BorderRadius.circular(25)
          //         //     // ),
          //         //     // focusedBorder: OutlineInputBorder(
          //         //     //   borderSide: BorderSide(
          //         //     //     color: Palette.blue
          //         //     //   ),
          //         //     //   borderRadius: BorderRadius.circular(25)
          //         //     // ),
          //         //     // hintText: 'Password',
          //         //     // hintStyle: TextStyle(
          //         //     //   fontSize: 14,
          //         //     //   color: Palette.textColor1
          //         //     // ),
          //         //     contentPadding: EdgeInsets.all(10.0)
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
          // // 버튼
          // Expanded(
          //   flex: 1,
          //   child: TextButton(
          //     onPressed: (){
          //       print('asdasdasd');
          //     }, 
          //     child: Text('zxasd')
          //   ),
          // ),
        ],
      ),
    );
  }
}