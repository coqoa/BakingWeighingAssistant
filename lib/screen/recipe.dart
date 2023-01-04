// ignore_for_file: prefer_const_constructors

import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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

  late int listIndex ;

  @override
  void initState() {
    super.initState();
    listIndex = 0;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          // 앱 바 
          Container(
            height: 60,
            color: Palette.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //앱 바 왼쪽 아이콘
                Container(
                  width: 80,
                  padding: EdgeInsets.only(left: 10),
                  // color: Colors.orange,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 14,
                          width: 14,
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
                  color: Colors.blue,
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
                  width: 80,
                  padding: EdgeInsets.only(right: 10),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //TODO 온탭이벤트
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(bottom: 1),
                        // color: Colors.blue,
                        child: SvgPicture.asset(
                          'assets/images/ic_clipboard.svg',
                          color: Palette.darkgray,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(top: 1),
                        // color: Colors.green,
                        child: SvgPicture.asset(
                          'assets/images/ic_bars.svg',
                          color: Palette.darkgray,
                        ),
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
                height: 46,
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
                width: 375,
                height: 541,
                // color: Colors.red,
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
                            width: 100,
                            height: 100,
                            color: Colors.red,
                            child: Center(
                              child: Text(controller.testList[index])
                            )
                          )
                        );
                      }
                    ),
                    // LEFT
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Container(
                          width: 50,
                          height: 500,
                          padding: EdgeInsets.only(left: 15),
                          // color: Colors.blue,
                          color: Colors.transparent,
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              'assets/images/ic_left.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                        onTap: (){
                          // 인디케이터 컬러변경
                          setState(() {
                            if(listIndex > 0) {listIndex = listIndex-1;}
                          });
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
                          ); // 페이지변경 애니메이션
                        },
                      ),
                    ),
                    // RIGHT
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Container(
                          width: 50,
                          height: 500,
                          padding: EdgeInsets.only(right: 15),
                          // color: Colors.green,
                          color: Colors.transparent,
                          child:  Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              'assets/images/ic_right.svg',
                              width: 20,
                              height: 20,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            if(listIndex+1 < controller.testList.length) {listIndex = listIndex+1;}
                          });
                          // 스크롤 이동
                          _scrollController.scrollToIndex(
                            listIndex,
                            duration: const Duration(milliseconds: 200),
                            preferPosition: AutoScrollPosition.middle,
                          );
                          // 페이지 이동
                          _pageController.animateToPage(
                            listIndex, 
                            curve: Curves.decelerate, 
                            duration: Duration(milliseconds: 300)
                          ); // 페이지변경 애니메이션
                        },
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}