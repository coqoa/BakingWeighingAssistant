
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
import 'package:bwa/widget/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
  String title = '';
  String changedTitle = '';
  bool settingClicked = false;
  bool circularIndicatorVisible = true;

  Validation validation = Validation();
   
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
  void initState() {
    super.initState();
    controller.loadMenuList();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        circularIndicatorVisible = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height; 
    final screenWidth = MediaQuery.of(context).size.width; 

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ((){
                return Obx((){
                  // info: 데이터가 없을 때 출력될 안내 페이지
                  if(controller.menuList.isEmpty){
                    return Center(
                      child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ? 익명 로그인시 출력되는 안내문구
                          if(FirebaseAuth.instance.currentUser?.email == null)
                          Column(
                            children: [
                              Text('If you start without logging in,',
                                style: TextStyle(

                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text('you may lose your data',
                                style: TextStyle(

                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  // * 익명로그인:
                                  controller.anonymousToPerpetual(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1, 
                                        color: Palette.black
                                    ) )
                                  ),
                                  child: Text('To join Gramming, tap here!',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
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
                                        leftButtonName: 'Back', 
                                        leftButtonFunction: (){}, 
                                        rightButtonName: 'Submit',
                                        rightButtonFuction:(){
                                          createMenu(title);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.5, color: Palette.lightblack),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  width: 180,
                                  height: 60,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.touch_app_outlined,
                                        color: Palette.black,
                                      ),
                                      SizedBox(width: 10,),
                                      Text('Create new menu',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                              )
                            ],
                          ),

                          if(FirebaseAuth.instance.currentUser?.email == null)
                          SizedBox()
                        ],
                      ),
                    );

                  }else{
                    // main:
                    return Theme(
                      // info: 드래그 디자인 지우는 부분
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
                          // info: 개별 Tile
                          Container(
                            key: Key(item),// ReorderableListView 자식 요소로 필수 
                            height: 200.h,
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
                                // CONTENTS_TITLE:
                                Center(
                                  child: GestureDetector(
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
                                
                                // nav: Tile 하단 버튼
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                          
                                      // INFO: EDIT 버튼
                                      GestureDetector(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          color: Palette.white,
                                          child: Center(
                                            child: Icon(Icons.mode_edit_outline_outlined,
                                                color:  Palette.gray,
                                                size: 24,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          title = item;
                                          _textController = TextEditingController(text: title);
                                          // modal:
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
                                                        key: GlobalKey(),
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
                                                leftButtonName: 'Back', 
                                                leftButtonFunction: (){}, 
                                                rightButtonName: 'Submit',
                                                rightButtonFuction:(){
                                                  editMenu(title, changedTitle);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            }
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10,),
                                      
                                      // info: DELETE 버튼
                                      GestureDetector(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          color: Palette.white,
                                          child: Center(
                                            child: Icon(Icons.delete_outline_rounded,
                                                color:  Palette.gray,
                                                size: 24,
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
                                                leftButtonName: 'Back', 
                                                leftButtonFunction: (){}, 
                                                rightButtonName: 'Submit',
                                                rightButtonFuction: (){
                                                  // db삭제기능 
                                                  deleteMenu(item);
                                                  Navigator.of(context).pop();
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
                    );
                  }
                });
            }()),
            
            
            
      
            // modal: Create 버튼
            if(controller.menuList.isNotEmpty)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: Center(
                    // child: SvgPicture.asset(
                    //   'assets/images/plus2.svg',
                    //   color: Palette.black,
                    //   width: 35,
                    //   height: 35,
                    // ),
                    child: Icon(Icons.add_circle_outline,
                      color: Palette.darkgray,
                      size: 30,
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
                        leftButtonName: 'Back', 
                        leftButtonFunction: (){}, 
                        rightButtonName: 'Submit',
                        rightButtonFuction:(){
                          createMenu(title);
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  );
                },
              ),
            ),

            // modal: 설정 버튼
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                  ),
                  child: Center(
                    // child: SvgPicture.asset(
                    //   'assets/images/setting2.svg',
                    //   color: Palette.black,
                    //   width: 28,
                    //   height: 28,
                    // ),
                    child: Icon(Icons.settings_outlined,
                      color: Palette.darkgray,
                      size: 25,
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
                  height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top, // info: 전체화면 - 상태바 크기
                  color: Colors.black.withOpacity(0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    // modal: 회원탈퇴, 로그아웃
                    child: Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Palette.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Palette.gray)
                      ),
                      margin: EdgeInsets.only(bottom: 50, left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // * 익명계정일경우?
                          if(FirebaseAuth.instance.currentUser?.email == null)
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                settingClicked = false;
                              });
                              controller.anonymousToPerpetual(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              color: Colors.transparent,
                              child: Center(
                                child: Text('Join us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
                                  ),
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              // modal: 회원탈퇴확인
                              showDialog(
                                context: context, 
                                builder: (_){
                                  return 
                                  DefaultAlertDialogTwoButton(
                                    title: 'Secession', 
                                    contents: SizedBox(
                                      child: Text('Are you sure?',
                                      style: TextStyle(
                                      color: Palette.black,
                                      fontSize: 21
                                    ),),
                                    ),
                                    leftButtonName: ' No ', 
                                    leftButtonFunction: (){}, 
                                    rightButtonName: 'Okay',
                                    rightButtonFuction:(){
                                      controller.secession(); 
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              );
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              color: Colors.transparent,
                              child: Center(
                                child: Text('Secession',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
                                  ),
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              FirebaseAuth.instance.signOut();
                              Get.off(Sign());   
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              color: Colors.transparent,
                              child: Center(
                                child: Text('Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
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
            ),
            if(circularIndicatorVisible)
            Center(
              child: Container(
                width: screenWidth,
                height: screenHeight,
                color: Palette.white,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    // color: Colors.blue,
                    child: CircularProgressIndicator(
                      color: Palette.black,
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}