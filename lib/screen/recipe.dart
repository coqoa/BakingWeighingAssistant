// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String currentUserEmail = FirebaseAuth.instance.currentUser!.email.toString();

  // TODO  스크린 유틸 라이브러리 써서 전체 수치 변경 + 중복제거 + 다른 페이지도 수치 변경////////////////////////////////////////////////////////
  double appBarHeight = 70;
  double listIndicatorHeight = 51;
  late double boxWidth = MediaQuery.of(context).size.width;
  late double boxHeight = MediaQuery.of(context).size.height;

  late int listIndex ;
  late bool memoOpen = false;

  @override
  void initState() {
    super.initState();
    listIndex = 0;
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                // 앱 바 
                Container(
                  height: appBarHeight,
                  color: Palette.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //앱 바 왼쪽 아이콘
                      Container(
                        width: 85,
                        padding: EdgeInsets.only(left: 10),
                        // color: Colors.orange,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                                width: 15,
                                child: SvgPicture.asset(
                                  'assets/images/ic_arrow_left2.svg',
                                  color: Palette.darkgray,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text('back',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Palette.darkgray,
                                  fontSize: 17,
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                      // 앱 바 타이틀
                      Container(
                        width: 200,
                        // color: Colors.blue,
                        child: Text('Boulangerie',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'jalnan',
                            color: Palette.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      // 앱 바 우측 아이콘
                      Container(
                        width: 85,
                        padding: EdgeInsets.only(right: 10),
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 메모 버튼
                            GestureDetector(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                // color: Colors.blue,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_clipboard.svg',
                                    width: 21,
                                    height: 21,
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
                            SizedBox(width: 5,),
                            // 추가 버튼
                            GestureDetector(
                              child: Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(top: 2),
                                // color: Colors.green,
                                child: FittedBox(
                                  fit: BoxFit.none,
                                  child: SvgPicture.asset(
                                    'assets/images/ic_plus.svg',
                                    width: 23,
                                    height: 23,
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
                          width: 230,
                          height: 36,
                          padding: EdgeInsets.only(left: 10, right: 10),
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
                                    height: 36,
                                    // color: Colors.red,
                                    margin: EdgeInsets.only(right: 10),
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
                      width: boxWidth,
                      height: boxHeight-appBarHeight-listIndicatorHeight,
                      // color: Colors.orange,
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.testList.length,
                            controller: _pageController,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: Container(
                                  width: 300,
                                  height: 500, // TODO 수정유틸적용시키기  /  메뉴페이지 로그아웃버튼 (우측상단))
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
                                          Container(
                                            width: 30,
                                            height: 30,
                                            // color: Colors.blue,
                                          ),
                                          Container(child: Text(controller.testList[index])),
                                          GestureDetector(
                                            child: Container(
                                              height: 30,
                                              width: 30,
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
                                      // TODO 여기여기ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ
                                      Container(
                                        width: 200,
                                        height: 300,
                                        color: Colors.red,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text('-----'),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text(controller.testList[index]),
                                              Text('-----'),
                                            ],
                                          ),
                                        )
                                      ),

                                      // 곱하기버튼
                                      GestureDetector(
                                        child: Container(
                                          width: 100,
                                          height: 40,
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
                                            child: Text('X ?',
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
                                          Navigator.of(context).pop();
                                          print('BTN CLICK');
                                        },
                                      )
                                    ],
                                  )
                                )
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

            // 메모장
            if(memoOpen)
            GestureDetector(
              onTap: (){
                setState(() {
                  memoOpen = false;
                });
              },
              child: Container(
                width: boxWidth,
                height: boxHeight,
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 450,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 20, right: 15),
                          // color: Colors.red[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Memo',
                                style: const TextStyle(
                                  fontFamily: 'jalnan',
                                  color: Palette.black,
                                  fontSize: 20
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 30,
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
                                onTap: (){
                                  Navigator.of(context).pop();
                                  print('BTN CLICK');
                                },
                              )
                            ],
                          )
                        ),
                        // 메모 텍스트 필드
                        Container(
                          height: 330,
                          // color: Colors.green[100],
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
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
          width: 50,
          height: 500,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.transparent,
          child:  Align(
            alignment: widget.direction, //
            child: SvgPicture.asset(
              widget.svg, //
              width: 20,
              height: 20,
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