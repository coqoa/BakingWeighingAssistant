import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  MenuController controller = MenuController();
  late TextEditingController _textController;
  
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  double adHeight = 56.0;
  String title = '';
  

  // late List changedList = controller.testList;

  @override
  void initState() {
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // height: GetPlatform.isMobile? boxHeight: 860.h, // 웹이면 변경
            // width: GetPlatform.isMobile ? boxWidth : 345.w, 
            // color: Palette.backgroundColor,
            color: Colors.red,

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
                  // onReorderStart: (index) {
                  // },
                  // onReorderEnd: (index) async{
                  //   print(index); // 놓여지는 위치
                  // },
              
                  children: controller.testList.map((item) => 
                    // 개별 Tile
                    Container(
                      key: Key(item),// ReorderableListView 자식 요소로 필수 
                      height: 250.h,
                      margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            blurRadius: 12,
                            offset: Offset(3.0, 6.0),
                            color: Color.fromRGBO(0, 0, 0, .10),
                          )
                        ]
                      ),
                      child: Stack(
                        children: [
                          // TITLE
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item,
                                  style: const TextStyle(
                                    // fontFamily: 'jalnan',
                                    color: Palette.lightblack,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ) 
                          ),
                          
                          // BOTTOM RIGHT BUTTON
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [

                                // EDIT
                                GestureDetector(
                                  child: SizedBox(
                                    width: 35.w,
                                    height: 35.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/pencil.svg',
                                        color: Palette.gray,
                                        width: 23,
                                        height: 23,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    title = item;
                                    _textController = new TextEditingController(text: title);
                                    showDialog(
                                      context: context, 
                                      builder: (_){
                                        return DefaultAlertDialogOneButton(
                                          title: 'Edit',
                                          contents: 
                                            SizedBox(
                                              width: 250.w,
                                              height: 100.h,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const SizedBox(),
                                                  TextField(
                                                    key: GlobalKey(), // 
                                                    controller: _textController, // 텍스트 기본값 설정 컨트롤러

                                                    style: const TextStyle(
                                                      fontSize: 25,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    cursorColor: Palette.lightblack,
                                                    cursorHeight: 25,
                                                    maxLength: 20,
                                                    autocorrect: false,

                                                    decoration: const InputDecoration(
                                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                                      filled: true,
                                                      fillColor: Palette.white,
                                                      isDense: true,
                                                      contentPadding: EdgeInsets.fromLTRB(10,0,10,2)
                                                    ),
                                                    
                                                    onChanged: (value){
                                                        setState(() {
                                                          title = value;
                                                        });
                                                    },
                                                    onSubmitted: (value){
                                                      if(item != value){
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          title = value;
                                                          // db변경 메소드
                                                        });
                                                      }else{
                                                        print('똑같으니까 쇼바텀시트로 알려주기');
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          buttonTitle: 'Ok',
                                          btnColor: Palette.lightblack,
                                          btnTextColor: Palette.white,
                                          confirmFunction: (){
                                            // 위의 onSubmitted 완성 후 붙여넣기
                                          },
                                        );
                                      }
                                    );
                                  },
                                ),
                                const SizedBox(width: 5,),
                                
                                // DELETE
                                GestureDetector(
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    // color: Colors.blue,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/images/eraser.svg',
                                        color: Palette.gray,
                                        width: 27,
                                        height: 27,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context, 
                                      builder: (_){
                                        return DefaultAlertDialogOneButton(
                                          title: 'Delete',
                                          contents: Container(
                                            width: 250,
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text('Are you sure delete',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 10,),
                                                Text('\'$item\'?',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          buttonTitle: 'Ok',
                                          btnColor: Palette.white,
                                          btnTextColor: Palette.red,
                                          confirmFunction: (){
                                            // db삭제기능 구현하기
                                          },
                                        );
                                      }
                                    );
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

          // CREATE
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              child: Lottie.asset('assets/lotties/plus-lottie.json',
                width: 60,height: 60
              ),
              onTap: (){
                showDialog(
                  context: context, 
                  builder: (_){
                    return DefaultAlertDialogOneButton(
                      title: 'Create',
                      contents: 
                        SizedBox(
                          width: 250.w,
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              TextField(
                                key: GlobalKey(), // 
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                                cursorColor: Palette.lightblack,
                                cursorHeight: 25,
                                maxLength: 20,
                                autocorrect: false,

                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                  filled: true,
                                  fillColor: Palette.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(10,0,10,2)
                                ),
                                
                                onChanged: (value){
                                    setState(() {
                                      title = value;
                                    });
                                },
                                onSubmitted: (value){
                                  Navigator.of(context).pop();
                                  setState(() {
                                    // title으로 db생성하는 메소드
                                  });
                              },
                              ),
                            ],
                          ),
                        ),
                      buttonTitle: 'Ok',
                      btnColor: Palette.lightblack,
                      btnTextColor: Palette.white,
                      confirmFunction: (){
                        // 위의 onSubmitted 완성 후 붙여넣기
                      },
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}