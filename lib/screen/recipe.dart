// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/controller/recipe_controller.dart';
import 'package:bwa/screen/addRecipe.dart';
import 'package:bwa/screen/editRecipe.dart';
import 'package:bwa/screen/menu.dart';
import 'package:bwa/widget/calculator.dart';
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
    // info: 스크롤 이동
    _scrollController.scrollToIndex(
      listViewIndex,
      preferPosition: AutoScrollPosition.middle,
    );
    // info: 계산기 초기화
    multiflyInitialize();
  }

  void multiflyInitialize(){}
  
  removeDotZero(e){
    if(e.toString().contains('.0')){
      return e.ceil();
    }else{
      return e;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; 
    final screenWidth = MediaQuery.of(context).size.width; 

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // header: 앱 바
              Container(
                height: 100,
                padding: EdgeInsets.only(top: 10, bottom: 10,),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // section: 앱 바 상단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // nav: 앱 바 왼쪽 아이콘
                        GestureDetector(
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/images/left1.svg',
                                color: Palette.gray,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          onTap: (){
                            // setState(() {
                            //   Get.off(()=>Menu()); // NOTE: to 로 할지 off로 할지 안드로이드로 확인해야함 //! get back?
                            // });
                            Navigator.of(context).pop();
                          },
                        ),
                        // nav: 앱 바 타이틀
                        Container(
                          width: 180.w,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(widget.menuTitle,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Palette.black,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),
                        ),
                        // nav: 앱 바 우측 아이콘
                        Container(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 40,
                                  color: Palette.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // SvgPicture.asset(
                                      //   'assets/images/memo1.svg',
                                      //   color: Palette.darkgray,
                                      //   width: 22,
                                      //   height: 22,
                                      // ),
                                      // Icon(Icons.mode_comment_outlined,
                                      Icon(Icons.event_note_rounded,
                                        color: Palette.gray,
                                        size: 25,
                                      ),
                                      Text('Memo',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Palette.gray,
                                          fontFamily: 'notosans'
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    // modal:
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
                                child: Container(
                                  width: 40,
                                  color: Palette.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // SvgPicture.asset(
                                      //   'assets/images/plus2.svg',
                                      //   color: Palette.darkgray,
                                      //   width: 25,
                                      //   height: 25,
                                      // ),
                                      // Icon(Icons.add,
                                      // Icon(Icons.add_box_outlined,
                                      Icon(Icons.add_box_outlined,
                                        color: Palette.gray,
                                        size: 25,
                                      ),
                                      Text('Add',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Palette.gray,
                                          fontFamily: 'notosans'
                                        ),
                                      )
                                    ],
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
        
                    // section: 레시피 리스트 인디케이터
                    Container(
                      width: 300,
                      height: 35,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                                // aside: 리스트 인디케이터 버튼
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Center(
                                    child: Text(
                                      controller.recipeList[index],
                                      style: TextStyle(
                                        color: listViewIndex == index ? Palette.black : Palette.gray, // darkgray
                                        fontWeight: listViewIndex == index ? FontWeight.w600 : FontWeight.normal, // regular
                                        fontSize: 16
                                      ),
                                    )
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    listViewIndex = index;
                                  });
                                  // INFO: 페이지 이동
                                  _pageController.animateToPage(listViewIndex, curve: Curves.decelerate, duration: Duration(milliseconds: 400));
                                  // INFO: 계산기 초기화
                                  multiflyInitialize();
                                },
                              )
                            );
                          }
                        );
                      })
                    ),
                  ],
                ),
              ),

              // main: 메인 컨텐츠
              Expanded(
                child: Obx((){
                  if(controller.requestStatus.value==RequestStatus.SUCCESS){
                    if(controller.recipeList.isEmpty){
                      // info: 리스트가 없으면 출력될 안내 페이지
                      return Center(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>AddRecipe(menuTitle: widget.menuTitle));
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
                                SvgPicture.asset(
                                  'assets/images/plus2.svg',
                                  color: Palette.black,
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(width: 10,),
                                Text('Add a new Recipe',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ]
                            )
                          ),
                        ),

                      );
                    }else{
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
                          // section: 레시피 메인
                          return Center(
                            child: Container(
                              width: 300.w,
                              height: screenHeight-220,
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              decoration: BoxDecoration(
                                color: Palette.white, 
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  const BoxShadow(
                                    blurRadius: 30,
                                    offset: Offset(0.8, 1.5),
                                    color: Color.fromRGBO(0, 0, 0, .2),
                                  )
                                ]
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                                    Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Palette.reallightgray,
                                              width: 1
                                            ),
                                          )
                                        ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // CONTENTS_TITLE: 타이틀
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
                                          // CONTENTS_DESCRIPTION: 레시피 표 첫 열
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 120.w,
                                                child: const Center(
                                                  child: Text('Ingredient',
                                                    style: TextStyle(
                                                      fontSize: 18,
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
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  // MODAL:
                                                                  if(controller.multipleValue.isNotEmpty){
                                                                    showDialog(
                                                                      context: context, 
                                                                      builder: (_){
                                                                        return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'multiple');
                                                                      }
                                                                    );
                                                                  }
                                                                },
                                                                child: Container(
                                                                  width: 45,
                                                                  child: Text(
                                                                    controller.multipleValue[index] == 1
                                                                    ? ''
                                                                    : 'x ${removeDotZero(controller.multipleValue[index])}',
                                                                    style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w800,
                                                                      color: Palette.red
                                                                    ),
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
                              
                                    // CONTENTS_DESCRIPTION: 레시피 본문
                                    SingleChildScrollView(
                                      child: Container(
                                        height: screenHeight-250-140, 
                                        child: Obx((){
                                          return ((){
                                            if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                              return ListView.builder(
                                                itemCount: controller.recipeIngredient[listViewIndex].length, 
                                                itemBuilder: ((context, idx) {
                                                  return Container(
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 120.w,
                                                          decoration: BoxDecoration(
                                                          ),
                                                          child: Center(
                                                            child: Text('${controller.recipeIngredient[listViewIndex][idx]}',
                                                              style: TextStyle(
                                                                fontSize: 16
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120.w,
                                                          child: Center(
                                                            child: Obx(() => 
                                                              controller.recipeWeight[listViewIndex][idx].length != 0 
                                                              ? Text(
                                                                '${removeDotZero(double.parse(controller.recipeWeight[listViewIndex][idx])*controller.multipleValue[index])}',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: controller.multipleValue[index] != 1 ? FontWeight.bold : FontWeight.normal
                                                                ),
                                                              )
                                                              : Text('')
                                                            )
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
                              
                                    // contents_footer: 총 합 / 나누기 섹션
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.only(left: 30, right: 30),
                                      decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Palette.reallightgray,
                                              width: 1
                                            ),
                                          )
                                        ),
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
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Palette.lightblack
                                                    ),
                                                  ),
                                                  Text(
                                                    '${removeDotZero(controller.recipeWeightTotal[index])} g',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: Palette.lightblack
                                                    ),
                                                  )
                                                ],
                                              ),
                                              controller.divideWeight[index] != 1
                                              ? Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Total ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette.lightblack
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          // modal:
                                                          if(controller.divideWeight.isNotEmpty){
                                                            showDialog(
                                                              context: context, 
                                                              builder: (_){
                                                                return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'divide');
                                                              }
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          '/ ${removeDotZero(controller.divideWeight[index]) } g',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w800,
                                                            color: Palette.blue
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${controller.recipeWeightTotal[index] ~/ controller.divideWeight[index]} ea',
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
                                          return Text('ERROR 568');
                                        }
                                      })
                                    ),
                                  ],
                                ),
                              )
                            )
                          );
                        }
                      );
                    }
                  }else{
                    return SizedBox();
                  }
                })
              ),
              
              // footer: 하단네비게이션바
              Container(
                height: 60,
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
                    // section: 연산 관련 버튼
                    Container(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // nav: 곱하기
                          GestureDetector(
                            onTap: (){
                              // modal:
                              if(controller.multipleValue.isNotEmpty){
                                showDialog(
                                  context: context, 
                                  builder: (_){
                                    return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'multiple');
                                  }
                                );
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              color: Palette.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx((){
                                    return 
                                    SvgPicture.asset(
                                      'assets/images/multiply1.svg',
                                      color: ((){
                                        if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                          if(controller.multipleValue.isNotEmpty){
                                            return controller.multipleValue[listViewIndex] == 1 ? Palette.gray : Palette.red; 
                                          }else{
                                            return Palette.gray;
                                          }
                                        }else{
                                          return Palette.gray;
                                        }
                                      }()),
                                      width: 24,
                                      height: 24,
                                    );
                                  }),
                                  Text('Multiply',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.gray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          // nav: 나누기
                          GestureDetector(
                            onTap: (){
                              // modal:
                              if(controller.divideWeight.isNotEmpty){
                                showDialog(
                                  context: context, 
                                  builder: (_){
                                    return  MultiflyWidget(menuTitle: widget.menuTitle, listViewIndex: listViewIndex, controller: controller, type:'divide');
                                  }
                                );
                              }
                            },
                            child:Container(
                              width: 60,
                              height: 60,
                              color: Palette.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx((){
                                    return 
                                    Icon(Icons.percent_rounded,
                                      color: ((){
                                        if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                          if(controller.divideWeight.isNotEmpty){
                                            return controller.divideWeight[listViewIndex] == 1 ? Palette.gray : Palette.blue;
                                          }else{
                                            return Palette.gray;
                                          }
                                        }else{
                                          return Palette.gray;
                                        }
                                      }()),
                                      size: 24,
                                    );
                                  }),
                                  Text('Divide',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.gray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                    // section: 수정 / 삭제 관련 버튼
                    Container(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // nav: 수정
                          GestureDetector(
                            onTap: (){
                              if(controller.recipeList.isNotEmpty){
                                Get.to(()=>EditRecipe(menuTitle: widget.menuTitle, multipleValue: controller.multipleValue[listViewIndex], divideWeight: controller.divideWeight[listViewIndex], recipeTitle: controller.recipeList[listViewIndex],));
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              color: Palette.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SvgPicture.asset(
                                  //   'assets/images/pencil1.svg',
                                  //   color: Palette.darkgray,
                                  //   width: 25,
                                  //   height: 25,
                                  // ),
                                  Icon(Icons.mode_edit_outline_outlined,
                                      color:  Palette.gray,
                                      size: 24,
                                  ),
                                  Text('Edit',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.gray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
        
                          // nav: 삭제
                          GestureDetector(
                            onTap: (){
                              // modal:
                              if(controller.recipeList.isNotEmpty){
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
                                      buttonTitle: 'Submit',
                                      btnColor: Palette.white,
                                      btnTextColor: Palette.red,
                                      confirmFunction: (){
                                        // INFO: db삭제기능 
                                        setState(() {
                                          controller.deleteRecipe(widget.menuTitle, listViewIndex);
                                        });
                                      },
                                    );
                                  }
                                );
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              color: Palette.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete_outline_rounded,
                                      color:  Palette.gray,
                                      size: 24,
                                  ),
                                  Text('Delete',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.gray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
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