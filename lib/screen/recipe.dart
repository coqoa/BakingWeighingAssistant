// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  RecipeController controller = RecipeController();
  final AutoScrollController _scrollController = AutoScrollController();
  final PageController _pageController = PageController();

  // firebase Auth
  // String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

  // TODO  스크린 유틸 라이브러리 써서 전체 수치 변경 + 중복제거 + 다른 페이지도 수치 변경////////////////////////////////////////////////////////
  double appBarHeight = 90.h;
  double listIndicatorHeight = 50.h;
  double contentHeight = 696.h;

  late int listIndex ;
  late bool memoOpen = false;
  late bool isMultifly = false;

  @override
  void initState() {
    super.initState();
    listIndex = 0;
  }
  
  void moveListPage(){
    // 스크롤 이동
    _scrollController.scrollToIndex(
      listIndex,
      duration: const Duration(milliseconds: 200),
      preferPosition: AutoScrollPosition.middle,
    );
    // 페이지 이동
    _pageController.animateToPage(
      listIndex, 
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate, 
    ); 
  }
    void moveListPageLeft(){
      setState(() {
        if(listIndex > 0) {
          listIndex = listIndex-1;
        }
      });
      moveListPage();
    }
    void moveListPageRight(){
      setState(() {
        if(listIndex+1 < controller.testList.length) {
  listIndex = listIndex+1;
        }
      });
      moveListPage();
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 앱 바 
                Container(
                  height: appBarHeight,
                  color: Palette.white,
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //앱 바 왼쪽 아이콘
                      Container(
                        width: 80.w,
                        // color: Colors.orange,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_arrow_left2.svg',
                              width: 15.w,
                              height: 15.h,
                              color: Palette.darkgray,
                            ),
                            Text(' back',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Palette.darkgray,
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                      // 앱 바 타이틀
                      Container(
                        width: 180.w,
                        // color: Colors.blue,
                        child: Center(
                          child: Text('Boulangerie',
                            style: const TextStyle(
                              // fontFamily: 'jalnan',
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      // 앱 바 우측 아이콘
                      Container(
                        width: 80.w,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 메모 버튼
                            GestureDetector(
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                // color: Colors.blue,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_clipboard.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    color: Palette.darkgray,
                                  ),
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  memoOpen = true;
                                });
                              },
                            ),
                            // SizedBox(width: 5.w,),
                            // 추가 버튼
                            GestureDetector(
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                // color: Colors.green,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_plus.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    color: Palette.darkgray,
                                  ),
                                ),
                              ),
                              onTap:(){
                                setState(() {
                                  print('추가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 메인 컨텐츠
                Column(
                  children: [
                    // 리스트 인디케이터
                    Container(
                      height: listIndicatorHeight,
                      decoration: BoxDecoration(
                      color: Palette.white,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset:Offset(0.0, 4.0),
                            color: Color.fromRGBO(219, 219, 219, 0.5)
                          )
                        ]
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 230.w,
                          height: 36.h,
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          decoration: BoxDecoration(
                            color: Palette.reallightgray,
                            borderRadius: BorderRadius.circular(20),
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset:Offset(0.0, 2.0),
                                color: Color.fromRGBO(219, 219, 219, 1)
                              )
                            ]
                          ),
                          // controller
                          child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.testList.length,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return AutoScrollTag(
                                key: ValueKey(index), 
                                controller: _scrollController, 
                                index: index, 
                                child: GestureDetector(
                                  // 메뉴 버튼
                                  child: Container(
                                    // color: Colors.red,
                                    margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: Center(
                                      child: Obx((){
                                        return Text(
                                          controller.testList[index],
                                          style: TextStyle(
                                            color: listIndex == index ? Palette.black : Palette.darkgray, // darkgray
                                            fontWeight: listIndex == index ? FontWeight.w900 : FontWeight.w400, // regular
                                            fontSize: 14
                                          ),
                                        );
                                      })
                                    ),
                                  ),
                                  // 터치 이벤트
                                  onTap: () {
                                    // 인디케이터 컬러변경
                                    setState(() {
                                      listIndex = index;
                                    });
                                    // 페이지 이동
                                    _pageController.animateToPage(index, curve: Curves.decelerate, duration: Duration(milliseconds: 300)); // 페이지변경 애니메이션
                                  },
                                )
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                    // 메인 컨텐츠
                    Container(
                      width: 360.w,
                      height: contentHeight,
                      // color: Colors.orange,
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.testList.length,
                            controller: _pageController,
                            itemBuilder: (BuildContext context, int index) {
          
                              int customPageindex = index;
          
                              return Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 300.w,
                                      height: 650.h, // TODO 수정유틸적용시키기  /  메뉴페이지 로그아웃버튼 (우측상단))
                                      padding: EdgeInsets.fromLTRB(15, 12, 15, 10),
                                      decoration: BoxDecoration(
                                        color: Palette.white,
                                        borderRadius: BorderRadius.circular(15),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          const BoxShadow(
                                            blurRadius: 12,
                                            offset: Offset(3.0, 6.0),
                                            color: Color.fromRGBO(0, 0, 0, .20),
                                          )
                                        ]
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                height: 30.h,
                                                // color: Colors.blue,
                                              ),
                                              // 타이틀
                                              Container(child: Text(controller.testList[index])),
                                              // 편집버튼
                                              GestureDetector(
                                                child: Container(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  // color: Colors.green,
                                                  child: Center(child: Text('편집')),
                                                  // child: FittedBox(
                                                  //   fit: BoxFit.none,
                                                  //   child: SvgPicture.asset(
                                                  //     'assets/images/pencil-solid.svg',
                                                  //     width: 20,
                                                  //     height: 20,
                                                  //     color: Palette.darkgray,
                                                  //   ),
                                                  // ),
                                                ),
                                                onTap:(){
                                                  setState(() {
                                                    print('편집!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          // 레시피 출력된는 곳 ////////////////////////////////////////////////////////////////////////////////////////////////////
                                          Container(
                                            width: 260.w,
                                            height: 530.h,
                                            color: Colors.red,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text('-----'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('$customPageindex'),
                                                  Text('-----'),
                                                ],
                                              ),
                                            )
                                          ),
                                          
                                          // 곱하기버튼
                                          GestureDetector(
                                            child: Container(
                                              width: 100.w,
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                // border: Border.all(color: Palette.darkgray, width: 2),
                                                color: Palette.black,
                                                borderRadius: BorderRadius.circular(15),
                                                // boxShadow: [
                                                //   const BoxShadow(
                                                //     blurRadius: 12,
                                                //     offset: Offset(0, 6.0),
                                                //     color: Color.fromRGBO(0, 0, 0, .40),
                                                //   )
                                                // ]
                                              ),
                                              child: Center(
                                                child: Text('1 X ?',
                                                  style: const TextStyle(
                                                    fontFamily: 'jalnan',
                                                    color: Palette.white,
                                                    // fontWeight: FontWeight.w900,
                                                    fontSize: 16
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: (){
                                              setState(() {
                                                isMultifly = true;
                                              });
                                              print('BTN CLICK');
                                            },
                                          )
                                        ],
                                      )
                                    )
                                  ),

                                  if(isMultifly)
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isMultifly = false;
                                        });
                                      },
                                      child: Container(
                                        width: 360.w,
                                        height: 780.h, // TODO 수정유틸적용시키기  /  메뉴페이지 로그아웃버튼 (우측상단))
                                        decoration: BoxDecoration(
                                          color: Palette.black.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              width: 300.w,
                                              height: 480.h,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MultiflyBtn(text: '7',index: 7, callback: (){},),
                                                      MultiflyBtn(text: '8',index: 8, callback: (){},),
                                                      MultiflyBtn(text: '9',index: 9, callback: (){},),
                                                    ]
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MultiflyBtn(text: '4', index: 4, callback: (){},),
                                                      MultiflyBtn(text: '5', index: 5, callback: (){},),
                                                      MultiflyBtn(text: '6', index: 6, callback: (){},),
                                                    ]
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MultiflyBtn(text: '1', index: 1, callback: (){},),
                                                      MultiflyBtn(text: '2', index: 2, callback: (){},),
                                                      MultiflyBtn(text: '3', index: 3, callback: (){},),
                                                    ]
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MultiflyBtn(text: '0', index: 0, callback: (){},),
                                                    ]
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      MultiflyBtn(text: '취소', index: 11, callback: (){setState(() {
                                                        isMultifly = false;
                                                      });},),
                                                      MultiflyBtn(text: '확인', index: 22, callback: (){

                                                      },),
                                                    ]
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ),


                                ],
                              );
                            }
                          ),
                          // LEFT 이동
                          MoveListPage(
                            direction: Alignment.centerLeft, 
                            svg: 'assets/images/ic_left.svg', 
                            callback: moveListPageLeft,
                          ),
                          // RIGHT 이동
                          MoveListPage(
                            direction: Alignment.centerRight, 
                            svg: 'assets/images/ic_right.svg', 
                            callback: moveListPageRight,
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 메모장
          if(memoOpen)
          GestureDetector(
            onTap: (){
              setState(() {
                memoOpen = false;
              });
            },
            child: Container(
              width: 360.w,
              height: 880.h,
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  width: 300.w,
                  height: 480.h,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50.h,
                        // color: Colors.red[100],
                        child: Center(
                          child: Text('Memo',
                            style: const TextStyle(
                              // fontFamily: 'jalnan',
                              fontWeight: FontWeight.w900,
                              color: Palette.black,
                              fontSize: 25
                              
                            ),
                          ),
                        )
                      ),
                      // 메모 텍스트 필드
                      Container(
                        height: 350.h,
                        // color: Colors.green[100],
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                      Container(
                        height: 50.h,
                        // color: Colors.red[100],
                        child: GestureDetector(
                          child: Center(
                            child: Container(
                              width: 120.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Palette.darkgray, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text('Save',
                                  style: const TextStyle(
                                    // fontFamily: 'jalnan',
                                    color: Palette.darkgray,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              memoOpen = false;
                            });
                          },
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

// 레시피 페이지 이동 버튼
class MoveListPage extends StatefulWidget {
  const MoveListPage({super.key, required this.direction, required this.svg, required this.callback});

  final Alignment direction;
  final String svg;
  final Function callback;

  @override
  State<MoveListPage> createState() => _MoveListPageState();
}

class _MoveListPageState extends State<MoveListPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.direction, //
      child: GestureDetector(
        child: Container(
          width: 50.w,
          height: 500.h,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.transparent,
          child:  Align(
            alignment: widget.direction, //
            child: SvgPicture.asset(
              widget.svg, //
              width: 20.w,
              height: 20.h,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        onTap: (){
          widget.callback(); // 
        },
      ),
    );
  }
}

class MultiflyBtn extends StatelessWidget {
  const MultiflyBtn({super.key, required this.index, required this.callback, required this.text});
  final String text;
  final int index;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('$index');
      },
      child: Container(
        width: 60.w,
        height: 60.h,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Palette.darkgray, width: 2),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Text(text,
            style: TextStyle(
              fontFamily: 'jalnan'
            ),
          )
        ),
      ),
    );
  }
}