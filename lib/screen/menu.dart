import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  String changedTitle = '';
  
  
  // late List changedList = controller.testList;

  @override
  void initState() {
    super.initState();
    controller.loadMenuList();
    // print(FirebaseAuth.instance.currentUser);
  }

  createMenu(e){
    controller.addMenu(e);
  }

  deleteMenu(e){
    controller.deleteMenu(e);
  }
  editMenu(title, changedTitle){
    controller.editMenu(title, changedTitle);
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              // color: Colors.red,
      
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
                        final moveItem = controller.menuList.removeAt(oldIndex);
                        controller.menuList.insert(newIndex, moveItem);
                        // print(controller.menuList);
                        controller.dragAndDropMenu();
                      // });
                    },
                    // onReorderStart: (index) {
                    // },
                    // onReorderEnd: (index) async{
                    //   print(index); // 놓여지는 위치
                    // },
                
                    children: controller.menuList.map((item) => 
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
                              child: GestureDetector(
                                // recipe 이동
                                onTap: (){
                                  controller.moveToMenuDetails(item);
                                },
                                child: Container(
                                  color: Palette.white,
                                  height: 200.h,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
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
                                    ),
                                  ),
                                ),
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
                                          return 
                                          DefaultAlertDialogTwoButton(
                                            title: 'Edit', 
                                            contents: SizedBox(
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
                                                    autofocus: true,
                    
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
                                                          changedTitle = value;
                                                        });
                                                    },
                                                    onSubmitted: (value){
                                                      Navigator.of(context).pop();
                                                      editMenu(title, changedTitle);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            leftButtonFunction: (){}, 
                                            rightButtonFuction:(){
                                              // 위의 onSubmitted 완성 후 붙여넣기\
                                              editMenu(title, changedTitle);
                                            },
                                            leftButtonName: '취소', 
                                            rightButtonName: '확인'
                                          );

                                          // DefaultAlertDialogOneButton(
                                          //   title: 'Edit',
                                          //   contents: 
                                          //     SizedBox(
                                          //       width: 250.w,
                                          //       height: 100.h,
                                          //       child: Column(
                                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           const SizedBox(),
                                          //           TextField(
                                          //             key: GlobalKey(), // 
                                          //             controller: _textController, // 텍스트 기본값 설정 컨트롤러
                      
                                          //             style: const TextStyle(
                                          //               fontSize: 25,
                                          //             ),
                                          //             textAlign: TextAlign.center,
                                          //             cursorColor: Palette.lightblack,
                                          //             cursorHeight: 25,
                                          //             maxLength: 20,
                                          //             autocorrect: false,
                                          //             autofocus: true,
                      
                                          //             decoration: const InputDecoration(
                                          //               enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                          //               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                          //               filled: true,
                                          //               fillColor: Palette.white,
                                          //               isDense: true,
                                          //               contentPadding: EdgeInsets.fromLTRB(10,0,10,2)
                                          //             ),
                                                      
                                          //             onChanged: (value){
                                          //                 setState(() {
                                          //                   changedTitle = value;
                                          //                 });
                                          //             },
                                          //             onSubmitted: (value){
      
                                          //               Navigator.of(context).pop();
                                          //               editMenu(title, changedTitle);
      
                                          //               // if(item != value){ // 조건 변경 -> 리스트 내부에 있으면 
                                          //               //   setState(() {
                                          //               //     title = value;
                                          //               //     // db변경 메소드
                                          //               //   });
                                          //               //   editMenu(title);
                                          //               // }else{
                                          //               //   print('존재하는 title이라고 쇼바텀시트로 알려주기');
                                          //               // }
                                          //             },
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   buttonTitle: 'Ok',
                                          //   btnColor: Palette.lightblack,
                                          //   btnTextColor: Palette.white,
                                          //   confirmFunction: (){
                                          //     // 위의 onSubmitted 완성 후 붙여넣기\
                                          //     editMenu(title, changedTitle);
                                          //   },
                                          // );
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
                                          return DefaultAlertDialogTwoButton(
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
                                                      fontSize: 19,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ), 
                                            leftButtonFunction: (){}, 
                                            rightButtonFuction: (){
                                              // db삭제기능 
                                              deleteMenu(item);
                                            }, 
                                            leftButtonName: '취소', 
                                            rightButtonName: '확인'
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
                      return DefaultAlertDialogTwoButton(
                        title: 'Create', 
                        contents: SizedBox(
                          width: 250.w,
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              TextField(
                                key: GlobalKey(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                                cursorColor: Palette.lightblack,
                                cursorHeight: 25,
                                maxLength: 20,
                                autocorrect: false,
                                autofocus: true,
    
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
                                onSubmitted: (v){
                                  Navigator.of(context).pop();
                                  createMenu(title);
                              },
                              ),
                            ],
                          ),
                        ),
                        leftButtonFunction: (){

                        }, 
                        rightButtonFuction:(){
                          // 위의 onSubmitted 완성 후 붙여넣기
                          createMenu(title);
                        },
                        leftButtonName: '취소', 
                        rightButtonName: '확인');
                    }
                  );
                },
              ),
            ),
            // 로그아웃 /TODO => 다음 페이지로 옮기는게 보기 좋을듯
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  width: 35.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: Palette.gray)
                  ),
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SvgPicture.asset(
                      'assets/images/logout.svg',
                      color: Palette.gray,
                      width: 23,
                      height: 23,
                    ),
                  ),
                ),
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Get.off(Sign());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}