// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:bwa/screen/addRecipe.dart';
import 'package:bwa/screen/editRecipe.dart';
import 'package:bwa/screen/menu.dart';
import 'package:bwa/widget/memo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../widget/default_alert_dialog_onebutton.dart';

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

  // 변수
  late int listViewIndex = 0;

  // 함수
  @override
  void initState() {
    super.initState();
    controller.loadRecipeList(widget.menuTitle);
    multiflyInitialize();
    _pageController.addListener(moveListPage);
  }

  moveListPage(){
    print('listViewIndex = $listViewIndex');
    // 스크롤 이동
    _scrollController.scrollToIndex(
      listViewIndex,
      preferPosition: AutoScrollPosition.middle,
    );
    // 계산기 초기화
    multiflyInitialize();
  }

  void multiflyInitialize(){}
  
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height; 

    return Scaffold(
      // backgroundColor: Palette.red,
      body: SafeArea(
        child: Container(
          height: screenHeight,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // HEADER: 앱 바
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset:Offset(0.0, 4.0),
                      color: Color.fromRGBO(219, 219, 219, 0.5)
                    )
                  ]
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SECTION: 앱 바
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // NAV: 앱 바 왼쪽 아이콘
                        GestureDetector(
                          child: Container(
                            width: 90.w,
                            // color: Colors.red,
                            // color: Colors.transparent,
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back_ios_new, 
                                color: Palette.gray, size: 17
                              )),
                          ),
                          onTap: (){
                            setState(() {
                              Get.off(()=>Menu()); // NOTE: to 로 할지 off로 할지 안드로이드로 확인해야함
                            });
                          },
                        ),
                        // NAV: 앱 바 타이틀
                        Container(
                          width: 180.w,
                          // color: Colors.blue,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(widget.menuTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Palette.black,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),
                        ),
                        // NAV: 앱 바 우측 아이콘
                        Container(
                          width: 90.w,
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 40,
                                    // height: 40,
                                    color: Palette.white,
                                    margin: EdgeInsets.only(right: 5),
                                    // child: Icon(Icons.chat_bubble_outline_sharp, color: Palette.lightblack, size: 25,),
                                    // child: Icon(Icons.chat, color: Palette.lightblack, size: 25,),
                                    // child: Icon(Icons.mark_chat_unread_outlined, color: Palette.lightblack, size: 25,),
                                    child: Icon(Icons.content_paste, color: Palette.gray, size: 22,),
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    // MODAL:
                                    showDialog(
                                    context: context, 
                                      builder: (_){
                                        return Memo(menuTitle: widget.menuTitle); 
                                      }
                                    );
                                  });
                                },
                              ),
                              GestureDetector(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 40,
                                    // height: 40,
                                    color: Palette.white,
                                    margin: EdgeInsets.only(right: 5),
                                    // child: Icon(Icons.add, color: Palette.lightblack, size: 25,),
                                    // child: Icon(Icons.post_add, color: Palette.lightblack, size: 30,),
                                    // child: Icon(Icons.note_add_outlined, color: Palette.lightblack, size: 26,),
                                    // child: Icon(Icons.assignment_rounded, color: Palette.lightblack, size: 30,),
                                    child: Icon(Icons.add, color: Palette.gray, size: 30,),
                                    // child: FittedBox(
                                    //   fit: BoxFit.none,
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/ic_plus1.svg',
                                    //     width: 20,
                                    //     height: 25,
                                    //     color: Palette.darkgray,
                                    //   ),
                                    // ),
                                  ),
                                ),
                                onTap: (){
                                  Get.to(()=>AddRecipe(menuTitle: widget.menuTitle));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // SECTION: 리스트 인디케이터
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.backgroundColor,
                        // ignore: prefer_const_literals_to_create_immutables
                        
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
                                      });
                                      // 페이지 이동
                                      _pageController.animateToPage(listViewIndex, curve: Curves.decelerate, duration: Duration(milliseconds: 400)); // 페이지변경 애니메이션
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

                  ],
                ),
              ),
              // MAIN: 메인 컨텐츠
              Expanded(
                child: Obx((){
                  return  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.recipeList.length,
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        listViewIndex = value;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      // SECTION: 레시피 메인
                      return Center(
                        child: Container(
                          width: 300.w,
                          height: screenHeight-220,
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: BoxDecoration(
                            // color: Colors.orange,
                            color: Palette.backgroundColor, 
                            borderRadius: BorderRadius.circular(15),
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 30,
                                offset: Offset(0.8, 1.5),
                                color: Color.fromRGBO(0, 0, 0, .13),
                              )
                            ]
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            // color: Colors.green[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CONTENT_TITLE: 타이틀
                                Container(
                                  height: 80,
                                  // color: Colors.purple,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx((){
                                        return((){
                                          if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                            return Text(controller.recipeList[index],
                                              style: const TextStyle(
                                                fontSize: 26,
                                                color: Palette.black
                                              ),
                                            );
                                          }else{
                                            return SizedBox();
                                          }
                                        }());
                                      }),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            child: const Center(
                                              child: Text('재료',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.w800
                                                ),
                                              )
                                            )
                                          ),
                                          SizedBox(
                                            width: 120.w,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text('g',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      // fontWeight: FontWeight.w800
                                                    ),
                                                  ),
                                                ),
                                                Obx((){
                                                  return ((){
                                                    if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                                      return Align(
                                                        alignment: Alignment.centerRight,
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Container(
                                                            width: 45,
                                                            child: Text(
                                                              // 'x 200',
                                                              controller.multipleValue[index] == 1
                                                              ? ''
                                                              : 'x ${controller.multipleValue[index]}',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                                color: Palette.red
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }else{
                                                      return SizedBox();
                                                    }
                                                  }());
                                                  
                                                })
                                              ]
                                            )
                                          ),
                                        ]
                                      ),
                                    ],
                                  ),
                                ),
                                // CONTENT_DISCRIPTION: 
                                SingleChildScrollView(
                                  child: Container(
                                    height: screenHeight-250-130, //INFO: 여기 손봐야함
                                    // color: Colors.grey,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Palette.reallightgray,
                                          width: 1
                                        ),
                                        bottom: BorderSide(
                                          color: Palette.reallightgray,
                                          width: 1
                                        ),
                                      )
                                    ),
                                    child: Obx((){
                                      return ((){
                                        if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                          return ListView.builder(
                                            itemCount: controller.recipeIngredient[listViewIndex].length, // TODO 여기여기!!!!
                                            itemBuilder: ((context, idx) {
                                              
                                              return Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    // top: BorderSide(
                                                    //   width: 0.5,
                                                    //   color: Palette.reallightgray
                                                    // ),
                                                    // bottom: BorderSide(
                                                    //   width: 0.5,
                                                    //   color: Palette.reallightgray
                                                    // ),
                                                  )
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 120.w,
                                                      decoration: BoxDecoration(
                                                        // border: Border(
                                                          // right: BorderSide(
                                                          //   width: 0.5,
                                                          //   color: Palette.reallightgray
                                                          // ),
                                                        // )
                                                      ),
                                                      child: Center(
                                                        child: Text('${controller.recipeIngredient[listViewIndex][idx]}',
                                                          style: TextStyle(
                                                            fontSize: 16
                                                          ),
                                                        ),
                                                      ),
                                                      // height: 50,
                                                    ),
                                                    Container(
                                                      width: 120.w,
                                                      // decoration: BoxDecoration(
                                                      //   border: Border(
                                                      //     left: BorderSide(
                                                      //       width: 0.5,
                                                      //       color: Palette.reallightgray
                                                      //     ),
                                                      //   )
                                                      // ),
                                                      child: Center(
                                                        child: Obx(() => controller.recipeWeight[listViewIndex][idx].length != 0 
                                                          ? Text(controller.recipeWeight[listViewIndex][idx].toString().contains('.')
                                                          // 실수
                                                          ?'${double.parse(controller.recipeWeight[listViewIndex][idx])*controller.multipleValue[index]}'
                                                          // 정수
                                                          :'${int.parse(controller.recipeWeight[listViewIndex][idx])*controller.multipleValue[index]}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: controller.multipleValue[index] != 1 ? FontWeight.bold : FontWeight.normal
                                                            ),
                                                          )
                                                          : Text(''))
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                          );
                                          
                                        }else{return Text('');}
                                      }());
                                    }),
                                  ),
                                ),
                                // CONTENT_FOOTER: 총 합 / 나누기 섹션
                                Container(
                                  // width: 120.w,
                                  height: 60,
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  // color: Colors.red,
                                  child: Obx((){
                                    if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total ',
                                                // '${controller.multipleValue[index]}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Palette.lightblack
                                                ),
                                              ),
                                              Obx((){
                                                return Text(
                                                  controller.recipeWeightTotal[index].toString().contains('.0')
                                                  ? '${controller.recipeWeightTotal[index].ceil()}g'
                                                  : '${controller.recipeWeightTotal[index]}g',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Palette.lightblack
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                          controller.divideValue[index] != 1
                                          ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                        Text(
                                                    'Total ',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Palette.lightblack
                                                    ),
                                                  ),
                                                  Text(
                                                    '/ ${controller.divideValue[index]}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w800,
                                                      color: Palette.blue
                                                    ),
                                                  ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '${controller.recipeWeightTotal[index] ~/ controller.divideValue[index]} ea',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Palette.lightblack
                                                ),
                                              ),
                                            ],
                                          )
                                          :SizedBox()
                                        ],
                                      );
                                    }else{
                                      return Text('ERROR 562');
                                    }
                                  })
                                ),
                          
                                // Container(
                                //   width: 120.w,
                                  
                                //   child: SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Obx((){
                                //     return Row(
                                //       children: [
                                //         Text(
                                //           // 'Total : 1000g / ${controller.divideValue.value[0]}g = 100 ea',
                                //           'Total = ',
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w500,
                                //             color: Palette.lightblack
                                //           ),
                                //         ),
                                //         Text(
                                //           // '${controller.recipeWeightTotal[listViewIndex]} g', //HERE: 여기문제
                                //           'g',
                                //           style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w800,
                                //             color: Palette.lightblack
                                //           ),
                                //         ),
                                //       ],
                                //     );
                                //   })
                                //   ),
                                // ),
                                // Container(
                                //   width: 120.w,
                                //   child: SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Obx((){
                                //     return Row(
                                //       children: [
                                //         Text(
                                //           // 'Total : 1000g / ${controller.divideValue.value[0]}g = 100 ea',
                                //           // 'Total / ${controller.divideValue.value[listViewIndex]}g = ',
                                //           'Total g = ',
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w500,
                                //             color: Palette.lightblack
                                //           ),
                                //         ),
                                //         Text(
                                //           // '${controller.recipeWeightTotal.value[listViewIndex] ~/ controller.divideValue.value[listViewIndex]} ea',
                                //           // style: TextStyle(
                                //           '${controller.recipeWeightTotal.value[listViewIndex] ~/ controller.divideValue.value[listViewIndex]} ea',
                                //           style: TextStyle(
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w800,
                                //             color: Palette.lightblack
                                //           ),
                                //         ),
                                //       ],
                                //     );
                                //   })
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        )
                      );
                    }
                  );
                })
              ),
              
              // FOOTER: 하단네비게이션바
              Container(
                height: 60,
                // color: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset:Offset(0.0, -4.0),
                      color: Color.fromRGBO(219, 219, 219, 0.4)
                    )
                  ]
                ),
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SECTION: 연산
                    Container(
                      width: 130,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NAV: 곱하기 아이콘
                          GestureDetector(
                            onTap: (){
                              // MODAL:
                              showDialog(
                                context: context, 
                                builder: (_){
                                  return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'multiple');
                                }
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              // color: Colors.orange,
                              child: Obx((){
                                return Icon(
                                  Icons.close, 
                                  color: ((){
                                    if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                      return controller.multipleValue[listViewIndex] == 1 ? Palette.lightgray : Palette.red; 
                                    }else{
                                      return Palette.lightgray;
                                    }
                                  }()),
                                  size: 22,
                                );
                              })
                            ),
                          ),
                          // // NAV: 나누기 아이콘
                          GestureDetector(
                            onTap: (){
                              // MODAL:
                              showDialog(
                                context: context, 
                                builder: (_){
                                  return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'divide');
                                }
                              );
                            },
                            child:Container(
                              width: 60,
                              height: 60,
                              // color: Colors.teal,
                              child: Obx((){
                                return Icon(
                                  Icons.safety_divider, 
                                  color: ((){
                                    if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                      return controller.divideValue[listViewIndex] == 1 ? Palette.lightgray : Palette.blue;
                                    }else{
                                      return Palette.lightgray;
                                    }
                                  }()), 
                                  size: 24,
                                );
                              })
                            )
                          ),
                        ],
                      ),
                    ),
                    // SECTION: 수정 / 삭제
                    Container(
                      width: 130,
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NAV: 수정 아이콘
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>EditRecipe(menuTitle: widget.menuTitle, multipleValue: controller.multipleValue[listViewIndex], recipeTitle: controller.recipeList[listViewIndex],));
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              // color: Colors.purple,
                              child: Icon(Icons.edit, color: Palette.gray, size: 22,),
                            ),
                          ),
                          // NAV: 삭제 아이콘
                          GestureDetector(
                            onTap: (){
                              // MODAL:
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
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Text('Are you sure delete ?',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 10,),
                                          Text("'${controller.recipeList[listViewIndex]}'",
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
                                      setState(() {
                                        print('DELETE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                        // Get.off(()=>Recipe(menuTitle: widget.menuTitle));
                                        controller.deleteRecipe(widget.menuTitle, listViewIndex);
                                        // 컨트롤러의 리스트를 변경한 뒤 db수정작업 + 새로고침? // TODO : 2023 02 09
                                      });
                                    },
                                  );
                                }
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              // color: Colors.pink,
                              child: Icon(Icons.delete_outline, color: Palette.gray, size: 22,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
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

class MultiflyWidget extends StatefulWidget {
  const MultiflyWidget({super.key, required this.menuTitle, required this.listViewIndex, required this.controller, required this.type});
  final String menuTitle;
  final int listViewIndex;
  final RecipeController controller;
  final String type;

  @override
  State<MultiflyWidget> createState() => _MultiflyWidgetState();
}

class _MultiflyWidgetState extends State<MultiflyWidget> {

  String multiflyIndicator = '';
  RecipeController controller = RecipeController();

  void multiflyCount(String s,String recipeTitle, int index){
    // print(s);
    // print(recipeTitle);
    // print(index);
    print(widget.type);
    setState(() {
      if(s == '<-'){
        // 빼기 구현
        if(multiflyIndicator.isNotEmpty ){
          multiflyIndicator = multiflyIndicator.substring(0, multiflyIndicator.length-1);
        }
      }else if(s == '확인'){
        // 적용하는 코드
        if(multiflyIndicator != ''){
          if(widget.type == 'multiple'){
            // print('MUL');
            widget.controller.multipleValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
          }else{
            // print('DIV');
            widget.controller.divideValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
          }
          
        }
        Navigator.of(context).pop();
      }else if(multiflyIndicator.isEmpty && s=='0'){

      }else{
        if(multiflyIndicator.length < 5){
          multiflyIndicator = multiflyIndicator+s;
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return 
      AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),

      backgroundColor: Palette.neumorphismColor,
      content: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          width: 270.w,
          height: 460.h,
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
                    // MultiflyBtn(text: '7', textColor: Palette.textColorWhite, callback: (){multiflyCount(widget.controller.recipeList[widget.listViewIndex]);}),
                    MultiflyBtn(text: '7', textColor: Palette.textColorWhite, callback: (){multiflyCount('7',widget.controller.recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '8', textColor: Palette.textColorWhite, callback: (){multiflyCount('8',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '9', textColor: Palette.textColorWhite, callback: (){multiflyCount('9',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MultiflyBtn(text: '4', textColor: Palette.textColorWhite, callback: (){multiflyCount('4',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '5', textColor: Palette.textColorWhite, callback: (){multiflyCount('5',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '6', textColor: Palette.textColorWhite, callback: (){multiflyCount('6',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MultiflyBtn(text: '1', textColor: Palette.textColorWhite, callback: (){multiflyCount('1',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '2', textColor: Palette.textColorWhite, callback: (){multiflyCount('2',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '3', textColor: Palette.textColorWhite, callback: (){multiflyCount('3',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MultiflyBtn(text: 'del', textColor: Palette.red, callback: (){multiflyCount('<-',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: '0', textColor: Palette.textColorWhite, callback: (){multiflyCount('0',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    MultiflyBtn(text: 'Enter', textColor: Palette.blue, callback: (){multiflyCount('확인',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                  ]
                ),
            ],
          ),
        ),
      ),


      elevation: 3,
    );
  }
}