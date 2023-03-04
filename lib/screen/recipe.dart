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
  
  // parsingDoubleToWeight(weight){
  //   for(int i=0; i<weight.length; i++){
  //     if(weight[i].length>0){
  //       weight[i] = double.parse(weight[i]);
  //     }
  //   }
  // }

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

    return Scaffold(
      // backgroundColor: Palette.red,
      body: SafeArea(
        child: Container(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // HEADER: 앱 바
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
                    // SECTION: 앱 바 상단
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // NAV: 앱 바 왼쪽 아이콘
                        GestureDetector(
                          child: Container(
                            width: 90.w,
                            padding: EdgeInsets.only(left: 10),
                            // color: Colors.red,
                            // color: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                'assets/images/left1.svg',
                                color: Palette.darkgray,
                                width: 30,
                                height: 30,
                              ),
                            ),
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
                                  fontSize: 22,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 40,
                                  color: Palette.white,
                                  // margin: EdgeInsets.only(right: 5),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/memo1.svg',
                                        color: Palette.darkgray,
                                        width: 22,
                                        height: 22,
                                      ),
                                      Text('Memo',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Palette.darkgray,
                                          fontFamily: 'notosans'
                                        ),
                                      )
                                    ],
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
                                child: Container(
                                  width: 40,
                                  // height: 40,
                                  color: Palette.white,
                                  // margin: EdgeInsets.only(right: 5),
                                  // child: Icon(Icons.add, color: Palette.lightblack, size: 25,),
                                  // child: Icon(Icons.post_add, color: Palette.lightblack, size: 30,),
                                  // child: Icon(Icons.note_add_outlined, color: Palette.lightblack, size: 26,),
                                  // child: Icon(Icons.assignment_rounded, color: Palette.lightblack, size: 30,),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/plus2.svg',
                                        color: Palette.darkgray,
                                        width: 25,
                                        height: 25,
                                      ),
                                      Text('Add',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Palette.darkgray,
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

                    // SECTION: 리스트 인디케이터
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
                                // ASIDE: 메뉴 버튼
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
                                  // 페이지 이동
                                  _pageController.animateToPage(listViewIndex, curve: Curves.decelerate, duration: Duration(milliseconds: 400));
                                  // 계산기 초기화
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
              // MAIN: 메인 컨텐츠
              Expanded(
              child: Obx((){
                if(controller.requestStatus.value==RequestStatus.SUCCESS){
                  if(controller.recipeList.length == 0){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('↗︎',
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.w800
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('Click the add button to create a new Menu',
                            style: TextStyle(
                              fontSize: 17,
                              // fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
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
                        // SECTION: 레시피 메인
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
                                  // CONTENT_TITLE: 타이틀
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
                                                                : 'x ${removeDotZero(controller.multipleValue[index])}',
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
                                      height: screenHeight-250-140, //INFO: 여기 손봐야함
                                      child: Obx((){
                                        return ((){
                                          if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                            return ListView.builder(
                                              itemCount: controller.recipeIngredient[listViewIndex].length, // TODO 여기여기!!!!
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
                                                              '${removeDotZero(controller.recipeWeight[listViewIndex][idx])}',
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
                            
                                  // CONTENT_FOOTER: 총 합 / 나누기 섹션
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
                                                  Text(
                                                    '/ ${controller.divideWeight[index]} g',
                                                    // 'bb',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w800,
                                                      color: Palette.blue
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
                                        return Text('ERROR 502');
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
              
              
              
              // FOOTER: 하단네비게이션바
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
                    // SECTION: 연산
                    Container(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NAV: 곱하기 아이콘
                          GestureDetector(
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
                                            return controller.multipleValue[listViewIndex] == 1 ? Palette.darkgray : Palette.red; 
                                          }else{
                                            return Palette.darkgray;
                                          }
                                        }else{
                                          return Palette.darkgray;
                                        }
                                      }()),
                                      width: 30,
                                      height: 30,
                                    );
                                  }),
                                  Text('Multiply',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.darkgray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          // // NAV: 나누기 아이콘
                          GestureDetector(
                            onTap: (){
                              // MODAL:
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
                              child: 
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx((){
                                    return 
                                    SvgPicture.asset(
                                      'assets/images/divide1.svg',
                                      color: ((){
                                        if(controller.requestStatus.value==RequestStatus.SUCCESS){
                                          if(controller.divideWeight.isNotEmpty){
                                            return controller.divideWeight[listViewIndex] == 1 ? Palette.darkgray : Palette.blue;
                                          }else{
                                            return Palette.darkgray;
                                          }
                                        }else{
                                          return Palette.darkgray;
                                        }
                                      }()),
                                      width: 30,
                                      height: 30,
                                    );
                                  }),
                                  Text('Divide',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.darkgray,
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
                    // SECTION: 수정 / 삭제
                    Container(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // NAV: 수정 아이콘
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
                                  SvgPicture.asset(
                                    'assets/images/pencil1.svg',
                                    color: Palette.darkgray,
                                    width: 25,
                                    height: 25,
                                  ),
                                  Text('Edit',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.darkgray,
                                      fontFamily: 'notosans'
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),

                          // NAV: 삭제 아이콘
                          GestureDetector(
                            onTap: (){
                              // MODAL:
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
                                        // db삭제기능 
                                        setState(() {
                                          // Get.off(()=>Recipe(menuTitle: widget.menuTitle));
                                          controller.deleteRecipe(widget.menuTitle, listViewIndex);
                                          // 컨트롤러의 리스트를 변경한 뒤 db수정작업 + 새로고침? // TODO : 2023 02 09
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
                              // child: Icon(Icons.delete_outline, color: Palette.gray, size: 22,),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/delete2.svg',
                                    color: Palette.darkgray,
                                    width: 27,
                                    height: 27,
                                  ),
                                  Text('Delete',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Palette.darkgray,
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

// // 계산기 다이얼로그 버튼
// class MultiflyBtn extends StatefulWidget {
//   const MultiflyBtn({super.key, required this.callback, required this.text, required this.textColor});
//   final String text;
//   final Color textColor;
//   final Function callback;

//   @override
//   State<MultiflyBtn> createState() => _MultiflyBtnState();
// }

// class _MultiflyBtnState extends State<MultiflyBtn> {

//   @override
//   Widget build(BuildContext context) {

//     double blur =  10;
//     Offset distance = Offset(4,4);

//     return GestureDetector(
//       onTap: (){
//         setState(() {
//           widget.callback();
//         });
//       },
//       child: Container(
//         width: widget.text == 'Enter' ? 200 : 60,
//         height: 50,
//         margin: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: Palette.neumorphismColor,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Palette.neumorphismBottomShadow,
//               blurRadius: blur,
//               offset: distance,
//             ),
//             BoxShadow(
//               color: Palette.neumorphismTopShadow,
//               blurRadius: blur,
//               offset: -distance,
//             ),
//           ]
//         ),
//         child: Center(
//           child: Text(widget.text,
//             style: TextStyle(
//               color: widget.textColor,
//               fontSize: 16,
//               fontWeight: FontWeight.w900
//             ),
//           )
//         ),
//       ),
//     );
//   }
// }

// class MultiflyWidget extends StatefulWidget {
//   const MultiflyWidget({super.key, required this.menuTitle, required this.listViewIndex, required this.controller, required this.type});
//   final String menuTitle;
//   final int listViewIndex;
//   final RecipeController controller;
//   final String type;

//   @override
//   State<MultiflyWidget> createState() => _MultiflyWidgetState();
// }

// class _MultiflyWidgetState extends State<MultiflyWidget> {

//   String multiflyIndicator = '';
//   RecipeController controller = RecipeController();

//   void multiflyCount(String s,String recipeTitle, int index){
//     // print(s);
//     // print(recipeTitle);
//     // print(index);
//     print(widget.type);
//     setState(() {
//       print(s.contains('.'));
//       if(s == '<-'){
//         // 빼기 구현
//         if(multiflyIndicator.isNotEmpty ){
//           multiflyIndicator = multiflyIndicator.substring(0, multiflyIndicator.length-1);
//         }
//       }else if(s == '확인'){
//         // 적용하는 코드
//         if(multiflyIndicator != ''){
//           if(widget.type == 'multiple'){
//             // print('MUL');
//             widget.controller.multipleValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
//           }else{
//             // print('DIV');
//             widget.controller.divideValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
//           }
          
//         }
//         Navigator.of(context).pop();
//       }else if(multiflyIndicator.isEmpty && s=='0'){
//       }else if(multiflyIndicator.isEmpty && s=='.'){
//       }else if(multiflyIndicator.isEmpty && s.contains('.')){

//       }else{
//         if(multiflyIndicator.length < 5){
//           multiflyIndicator = multiflyIndicator+s;
//         }
//       }
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency,
//       child: Center(
//         child: Container(
//             height: 390,
//             width: 230,
//             decoration: BoxDecoration(
//               color: Palette.neumorphismColor,
//               borderRadius: BorderRadius.circular(15)
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     width: 200,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Palette.reallightgray,
//                       borderRadius: BorderRadius.circular(10),
//                       // ignore: prefer_const_literals_to_create_immutables
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 10,
//                           offset: Offset(0,3),
//                         ),
//                       ]
//                     ),
//                     child: Center(
//                       child: Text(multiflyIndicator,
//                         style: TextStyle(
//                           color: Palette.black,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w900
//                         ),
//                       ),
//                     )
//                   ),
//                   SizedBox(height: 15.h,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MultiflyBtn(text: '7', textColor: Palette.textColorWhite, callback: (){multiflyCount('7',widget.controller.recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '8', textColor: Palette.textColorWhite, callback: (){multiflyCount('8',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '9', textColor: Palette.textColorWhite, callback: (){multiflyCount('9',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                     ]
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MultiflyBtn(text: '4', textColor: Palette.textColorWhite, callback: (){multiflyCount('4',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '5', textColor: Palette.textColorWhite, callback: (){multiflyCount('5',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '6', textColor: Palette.textColorWhite, callback: (){multiflyCount('6',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                     ]
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MultiflyBtn(text: '1', textColor: Palette.textColorWhite, callback: (){multiflyCount('1',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '2', textColor: Palette.textColorWhite, callback: (){multiflyCount('2',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '3', textColor: Palette.textColorWhite, callback: (){multiflyCount('3',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                     ]
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MultiflyBtn(text: '.', textColor: Palette.textColorWhite, callback: (){multiflyCount('.',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: '0', textColor: Palette.textColorWhite, callback: (){multiflyCount('0',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                       MultiflyBtn(text: 'del', textColor: Palette.red, callback: (){multiflyCount('<-',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                     ]
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MultiflyBtn(text: 'Enter', textColor: Palette.blue, callback: (){multiflyCount('확인',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
//                     ]
//                   )
//               ],
//             ),
//           ),
//       ),
//     );


//       // elevation: 3,
//   }
// }