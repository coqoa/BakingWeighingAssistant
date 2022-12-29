import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/menu_controller.dart';
import '../widget/default_alert_dialog_onebutton.dart';
import '../widget/default_alert_dialog_twobutton.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  double adHeight = 56.0;
  

  MenuController controller = MenuController();
  // late List changedList = controller.testList;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      // backgroundColor: Color.fromARGB(250, 235, 235, 235),
      
      body: Stack(
        children: [
          Container(
            height: GetPlatform.isMobile? boxHeight: 637, // 웹이면 변경
            width: GetPlatform.isMobile ? boxWidth : 375, 
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 30),

            child: Obx(()=>
              Theme(
                // 드래그 디자인 지우기
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    // setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final moveItem = controller.testList.removeAt(oldIndex);
                      controller.testList.insert(newIndex, moveItem);
              
                      print(controller.testList); // controller에서 리스트 교체하는 함수 필요함
                    // });
                  },
                  onReorderStart: (index) {
                  },
                  onReorderEnd: (index) async{
                    print(index); // 놓여지는 위치
                  },
              
                  children: controller.testList.map((item) => 
                    Container(
                      key: Key(item),// ReorderableListView 자식 요소로 필수 
                      // width: 300,
                      height: 180,
                      margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            offset: const Offset(3.0, 6.0),
                            color: Color.fromRGBO(0, 0, 0, .10),
                          )
                        ]
                      ),
                      child: Stack(
                        children: [
                          Center(
                            // alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item,
                                  style: const TextStyle(
                                    fontFamily: 'jalnan',
                                    color: Palette.lightblack,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ) 
                          ),
                          
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/pencil-solid.svg',
                                        color: Palette.gray,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context, 
                                      builder: (_){
                                        return DefaultAlertDialogOneButton(
                                          title: 'EDIT', 
                                          contents: Container(
                                            width: 250,
                                            height: 100,
                                            // color: Colors.red,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                TextField(
                                                  key: GlobalKey(), // 
                                                  keyboardType: TextInputType.emailAddress,
                                                
                                                  cursorColor: Palette.lightblack,
                                                  cursorWidth: 2,
                                                  cursorHeight: 20,
                                                  autofocus: true,
                                                  autocorrect: false, // 

                                                  // textInputAction: widget.textInputAction,
                                                
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),

                                                  decoration: const InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                                    filled: true,
                                                    fillColor: Palette.white,
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.fromLTRB(10,0,10,5)
                                                  ),
                                                  
                                                  onChanged: (value){
                                                      // widget.controller.textFieldChanged(widget.type, value);
                                                  },
                                                  onSubmitted: (_){
                                                    // if(widget.nextEvent){
                                                    //   // next Scope 이벤트
                                                    // }else{
                                                    //   if(widget.sign){
                                                    //     widget.controller.signIn('SignIn');
                                                    //   }else{
                                                    //     widget.controller.signUp('SignUp');
                                                    //   }
                                                    // }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          buttonTitle: 'Ok',
                                          confirmFunction: (){

                                          },
                                        );
                                      }
                                    );

                                    // // // 투버튼
                                    // showDialog(
                                    //   context: context, 
                                    //   builder: (_){
                                    //     return DefaultAlertDialogTwoButton(
                                    //       title: 'EDIT',
                                    //       contents: Text('수정창'), 
                                    //       leftButtonFunction: (){}, 
                                    //       leftButtonName: 'No', 
                                    //       rightButtonFuction: (){}, 
                                    //       rightButtonName: 'Ok', 
                                    //     );
                                    //   }
                                    // );
                                  },
                                ),
                                const SizedBox(width: 5,),
                                InkWell(
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    // color: Colors.blue,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/eraser-solid.svg',
                                        color: Palette.gray,
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print('$item 삭제!?');
                                  },
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                    )
                  ).toList(),
                ),
              )
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Lottie.asset('assets/lotties/plus-lottie.json',),
              ),
              onTap: (){
                // 원버튼
                showDialog(
                  context: context, 
                  builder: (_){
                    return DefaultAlertDialogOneButton(
                      title: 'title', 
                      contents: Text('contents'), 
                      buttonTitle: 'BTN',
                      confirmFunction: (){},
                    );
                  }
                );
                // // 투버튼
                // showDialog(
                //   context: context, 
                //   builder: (_){
                //     return DefaultAlertDialogTwoButton(
                //       title: '',
                //       contents: Text('data'), 
                //       leftButtonFunction: (){}, 
                //       leftButtonName: 'L', 
                //       rightButtonFuction: (){}, 
                //       rightButtonName: 'R', 
                //     );
                //   }
                // );
              },
            ),
          ),
          // ParameterTestWidget(param1: 'param1',param2: 'param2', param3:'param3', param4:4)
        ],
      ),
    );
  }
}

// class ParameterTestWidget extends StatefulWidget {
//   ParameterTestWidget({super.key, required this.param1, required this.param2, this.param3, this.param4});
//   final String param1; // required
//   final String param2; // required
//   dynamic param3; // optinal
//   var param4; // optinal
  

//   @override
//   State<ParameterTestWidget> createState() => _ParameterTestWidgetState();
// }

// class _ParameterTestWidgetState extends State<ParameterTestWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.param1),
//         Text(widget.param2),
//         Text(widget.param3),
//         Text(widget.param4),
//       ],
//     );
//   }
// }