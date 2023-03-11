
import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/menu_controller.dart';
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
  bool settingClicked = false;
  
  @override
  void initState() {
    super.initState();
    controller.loadMenuList();
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
              Obx((){
              if(controller.requestStatus.value==RequestStatus.SUCCESS){
                if(controller.menuList.length == 0 ){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Click the add button to create a new Menu',
                          style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('↘︎',
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.w800
                          ),
                        )
                      ],
                    ),
                  );
                }else{

                  return Theme(
                    //INFO: 드래그 디자인 지우기
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveItem = controller.menuList.removeAt(oldIndex);
                        controller.menuList.insert(newIndex, moveItem);
                        controller.dragAndDropMenu();
                      },
                  
                      children: controller.menuList.map((item) => 
                        // INFO: 개별 Tile
                        Container(
                          key: Key(item),// ReorderableListView 자식 요소로 필수 
                          height: 250.h,
                          margin: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 12,
                                offset: Offset(3.0, 6.0),
                                color: Color.fromRGBO(0, 0, 0, .2),
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
                                    width: 300,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(item,
                                          style: const TextStyle(
                                            // fontFamily: 'jalnan',
                                            color: Palette.lightblack,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
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
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Palette.white,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/images/pencil1.svg', 
                                            color: Palette.gray,
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        title = item;
                                        _textController = TextEditingController(text: title);
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
                                              leftButtonName: 'Back', 
                                              rightButtonName: 'Submit'
                                            );
                                          }
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10,),
                                    
                                    // DELETE
                                    GestureDetector(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Palette.white,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/images/delete2.svg',
                                            color: Palette.gray,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context, 
                                          builder: (_){
                                            return DefaultAlertDialogTwoButton(
                                              title: 'Delete', 
                                              contents: SizedBox(
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
                                              leftButtonName: 'Back', 
                                              rightButtonName: 'Submit'
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
                  );
                }
              }else{
                return SizedBox();
              }
            }
            ),
            
      
            // CREATE
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  // child: Lottie.asset('assets/lotties/plus-lottie.json',
                  //   width: 60,height: 60
                  // ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/plus2.svg',
                      color: Palette.black,
                      width: 35,
                      height: 35,
                    ),
                  ),
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
                        leftButtonName: 'Back', 
                        rightButtonName: 'Submit');
                    }
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  // margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/setting2.svg',
                      color: Palette.lightgray,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                onTap: (){
                  setState(() {
                    settingClicked = true;
                  });
                },
              ),
            ),
            if(settingClicked)
            Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    settingClicked = false;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top, //전체화면 - 상태바 크기
                  color: Colors.black.withOpacity(0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Palette.gray)
                      ),
                      margin: EdgeInsets.only(bottom: 50, left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // // LATE: 언어선택 부분 미구현
                          // Container(
                          //   width: 100,
                          //   height: 40,
                          //   color: Colors.red,
                          // ),
                          GestureDetector(
                            onTap: (){
                              FirebaseAuth.instance.signOut();
                              Get.off(Sign());   
                            },
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              // color: Colors.green,
                              child: Center(
                                child: Text('Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.w800, 
                                    color: Palette.darkgray,
                                    // fontFamily: 'notosans'
                                  ),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}