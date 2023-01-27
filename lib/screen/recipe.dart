// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:bwa/screen/addRecipe.dart';
import 'package:bwa/widget/memo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Recipe extends StatefulWidget {
  const Recipe({Key? key, required this.menuTitle}) : super(key: key);
  
  final String menuTitle;

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  RecipeController controller = RecipeController();
  final AutoScrollController _scrollController = AutoScrollController();
  final PageController _pageController = PageController();

  // TODO  스크린 유틸 라이브러리 써서 전체 수치 변경 + 중복제거 + 다른 페이지도 수치 변경////////////////////////////////////////////////////////
  // 변수
  double appBarHeight = 90.h;
  double listIndicatorHeight = 50.h;
  double contentHeight = 696.h;

  late bool memoOpen = false;
  late bool isMultifly = false;
  late int multiflyCountResult;
  String multiflyIndicator = '';

  late int listViewIndex;

  // 함수
  @override
  void initState() {
    super.initState();
    // listIndex = 0;
    
    controller.loadRecipeList(widget.menuTitle);

    listViewIndex = 0;
    multiflyInitialize();
    _pageController.addListener(moveListPage);
  }

  moveListPage(){
    setState(() {
      listViewIndex = _pageController.page!.ceil();
      // 계산기 창 닫기
      isMultifly = false;
    });
        // 스크롤 이동
    _scrollController.scrollToIndex(
      listViewIndex,
      // duration: const Duration(milliseconds: 100),
      preferPosition: AutoScrollPosition.middle,
    );
    // 계산기 초기화
    multiflyInitialize();
    print(listViewIndex);
  }
  void multiflyInitialize(){
    multiflyCountResult = 1;
  }
  
  void multiflyCount(String s){
    setState(() {
      if(s == '<-'){
        // 빼기 구현
        if(multiflyIndicator.isNotEmpty ){
          multiflyIndicator = multiflyIndicator.substring(0, multiflyIndicator.length-1);
        }
      }else if(s == '확인'){
        // 적용하는 코드
        if(multiflyIndicator != ''){
          multiflyCountResult = int.parse(multiflyIndicator);
        }
        isMultifly = false;
      }else if(multiflyIndicator.isEmpty && s=='0'){
        print('0은 첫자리로 올 수 없다');
      }
      else{
        if(multiflyIndicator.length < 6){
          multiflyIndicator = multiflyIndicator+s;
        }
      }
    });
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
                  decoration: BoxDecoration(
                    color: Palette.backgroundColor,
                  ),
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //앱 바 왼쪽 아이콘
                      GestureDetector(
                        child: Container(
                          width: 80.w,
                          color: Palette.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 12.w,
                                  height: 20.h,
                                  // color: Colors.red,
                                  padding: EdgeInsets.only(top: 2),
                                child: SvgPicture.asset(
                                  'assets/images/ic_left.svg',
                                  color: Palette.lightgray,
                                ),
                              ),
                              Text(' back',
                                style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  color: Palette.gray,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            // isMultifly = false;
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      // 앱 바 타이틀
                      Container(
                        width: 180.w,
                        // color: Colors.blue,
                        child: Center(
                          child: Text(widget.menuTitle,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Palette.black
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
                                color: Palette.white,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_clipboard.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    color: Palette.gray,
                                  ),
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  // memoOpen = true;
                                  showDialog(
                                  context: context, 
                                    builder: (_){
                                      return Memo(memoOpen: memoOpen, contents: memoOpen.toString()); // TODO: contents박아넣기
                                    }
                                  );

                                  isMultifly = false;
                                });
                              },
                            ),
                            // SizedBox(width: 5.w,),
                            // 추가 버튼
                            GestureDetector(
                              child: Container(
                                width: 30.w,
                                height: 30.h,
                                color: Palette.white,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_plus.svg',
                                    width: 27.w,
                                    height: 27.h,
                                    color: Palette.gray,
                                  ),
                                ),
                              ),
                              onTap:(){
                                setState(() {
                                  isMultifly = false;
                                  Get.to(()=>AddRecipe(menuTitle: widget.menuTitle));
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
                        color: Palette.backgroundColor,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            offset:Offset(0.0, 4.0),
                            color: Color.fromRGBO(219, 219, 219, 0.5)
                          )
                        ]
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 230.w,
                          height: 38.h,
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
                          // 리스트 인디케이터 컨텐츠
                          child:Obx((){
                            return  ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.recipeList.length,
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
                                        child: Text(
                                          controller.recipeList[index],
                                          style: TextStyle(
                                            color: listViewIndex == index ? Palette.black : Palette.gray, // darkgray
                                            fontWeight: listViewIndex == index ? FontWeight.w500 : FontWeight.normal, // regular
                                            fontSize: 16
                                          ),
                                        )
                                      ),
                                    ),
                                    // 터치 이벤트
                                    onTap: () {
                                      // 인디케이터 컬러변경
                                      setState(() {
                                        listViewIndex = index;
                                        isMultifly = false;
                                      });
                                      // 페이지 이동
                                      _pageController.animateToPage(listViewIndex, curve: Curves.decelerate, duration: Duration(milliseconds: 100)); // 페이지변경 애니메이션
                                      // 계산기 초기화
                                      multiflyInitialize();
                                    },
                                  )
                                );
                              }
                            );
                          })
                        ),
                      ),
                    ),

                    // 메인 컨텐츠
                    Container(
                      width: 360.w,
                      height: contentHeight,
                      // color: Colors.orange,
                      child: Obx((){
                        return  Stack(
                          children: [
                            PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.recipeList.length,
                              controller: _pageController,
                              itemBuilder: (BuildContext context, int index) {
            
                                int customPageindex = index;
            
                                return Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 300.w,
                                        height: 650.h, // TODO 수정유틸적용시키기  /  메뉴페이지 로그아웃버튼 (우측상단))
                                        padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                                        decoration: BoxDecoration(
                                          color: Palette.backgroundColor,
                                          borderRadius: BorderRadius.circular(15),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            const BoxShadow(
                                              blurRadius: 30,
                                              offset: Offset(3.0, 6.0),
                                              color: Color.fromRGBO(0, 0, 0, .2),
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
                                                Container(
                                                  child: Text(
                                                    controller.recipeList[index],
                                                    style: const TextStyle(
                                                      fontSize: 23,
                                                      fontWeight: FontWeight.bold,
                                                      color: Palette.black
                                                    ),
                                                  )
                                                ),
                                                // 편집버튼
                                                GestureDetector(
                                                  child: Container(
                                                    width: 30.w,
                                                    height: 30.h,
                                                    // color: Colors.green,
                                                    child: FittedBox(
                                                      fit: BoxFit.none,
                                                      child: SvgPicture.asset(
                                                        'assets/images/pencil.svg',
                                                        width: 20,
                                                        height: 20,
                                                        color: Palette.gray,
                                                      ),
                                                    ),
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
                                              height: 490.h,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                border: Border.all(width: 2, color: Palette.reallightgray)
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text('-----'),
                                                    Text('$customPageindex'),
                                                    Text('-----'),
                                                  ],
                                                ),
                                              )
                                            ),
                                            
                                            // 곱하기버튼
                                            GestureDetector(
                                              child: Container(
                                                width: 120.w,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                  // border: Border.all(color: Palette.darkgray, width: 2),
                                                  color: Palette.black,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text('× $multiflyCountResult',
                                                    style: const TextStyle(
                                                      color: Palette.textColorWhite,
                                                      fontWeight: FontWeight.w900,
                                                      fontSize: 18
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                setState(() {
                                                  multiflyIndicator = '';
                                                  isMultifly = true;
                                                });
                                                print('BTN CLICK');
                                              },
                                            )
                                          ],
                                        )
                                      )
                                    ),

                                    // 계산기
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
                                          height: 800.h, // TODO 수정유틸적용시키기  /  메뉴페이지 로그아웃버튼 (우측상단))
                                          decoration: BoxDecoration(
                                            color: Palette.modalBackgroundColor
                                          ),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: (){},
                                              child: Container(
                                                width: 240.w,
                                                height: 450.h,
                                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                decoration: BoxDecoration(
                                                  color: Palette.neumorphismColor,
                                                  borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 200.w,
                                                      height: 70.h,
                                                      decoration: BoxDecoration(
                                                        color: Palette.reallightgray,
                                                        borderRadius: BorderRadius.circular(10),
                                                        // ignore: prefer_const_literals_to_create_immutables
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 10,
                                                            offset: Offset(0,3),
                                                          ),
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: Text(multiflyIndicator,
                                                          style: TextStyle(
                                                            color: Palette.black,
                                                            fontSize: 30,
                                                            fontWeight: FontWeight.w900
                                                          ),
                                                        ),
                                                      )
                                                    ),
                                                    SizedBox(height: 15.h,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        MultiflyBtn(text: '7', textColor: Palette.textColorWhite, callback: (){multiflyCount('7');}),
                                                        MultiflyBtn(text: '8', textColor: Palette.textColorWhite, callback: (){multiflyCount('8');}),
                                                        MultiflyBtn(text: '9', textColor: Palette.textColorWhite, callback: (){multiflyCount('9');}),
                                                      ]
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        MultiflyBtn(text: '4', textColor: Palette.textColorWhite, callback: (){multiflyCount('4');}),
                                                        MultiflyBtn(text: '5', textColor: Palette.textColorWhite, callback: (){multiflyCount('5');}),
                                                        MultiflyBtn(text: '6', textColor: Palette.textColorWhite, callback: (){multiflyCount('6');}),
                                                      ]
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        MultiflyBtn(text: '1', textColor: Palette.textColorWhite, callback: (){multiflyCount('1');}),
                                                        MultiflyBtn(text: '2', textColor: Palette.textColorWhite, callback: (){multiflyCount('2');}),
                                                        MultiflyBtn(text: '3', textColor: Palette.textColorWhite, callback: (){multiflyCount('3');}),
                                                      ]
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        MultiflyBtn(text: 'del', textColor: Palette.red, callback: (){multiflyCount('<-');}),
                                                        MultiflyBtn(text: '0', textColor: Palette.textColorWhite, callback: (){multiflyCount('0');}),
                                                        MultiflyBtn(text: 'Enter', textColor: Palette.blue, callback: (){multiflyCount('확인');}),
                                                      ]
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      )
                                    ),
                                  ],
                                );
                              }
                            ),
                          ],
                        );
                      })
                    ),
                  ],
                ),
              ],
            ),
          ),

          // // 메모장
          // if(memoOpen)
            
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
          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
          color: Colors.transparent,
          child:  Align(
            alignment: widget.direction, //
            child: SvgPicture.asset(
              widget.svg, //
              width: 25.w,
              height: 25.h,
              color: Palette.lightgray
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

// 계산기 다이얼로그 버튼
class MultiflyBtn extends StatefulWidget {
  const MultiflyBtn({super.key, required this.callback, required this.text, required this.textColor});
  final String text;
  final Color textColor;
  final Function callback;

  @override
  State<MultiflyBtn> createState() => _MultiflyBtnState();
}

class _MultiflyBtnState extends State<MultiflyBtn> {

  @override
  Widget build(BuildContext context) {

    double blur =  10;
    Offset distance = Offset(4,4);

    return GestureDetector(
      onTap: (){
        setState(() {
          widget.callback();
        });
      },
      child: Container(
        width: 60.w,
        height: 70.h,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Palette.neumorphismColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Palette.neumorphismBottomShadow,
              blurRadius: blur,
              offset: distance,
            ),
            BoxShadow(
              color: Palette.neumorphismTopShadow,
              blurRadius: blur,
              offset: -distance,
            ),
          ]
        ),
        child: Center(
          child: Text(widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w900
            ),
          )
        ),
      ),
    );
  }
}