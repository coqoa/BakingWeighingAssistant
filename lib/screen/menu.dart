import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/menu_controller.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  double adHeight = 56.0;
  

  MenuController controller = MenuController();
  // late List changedList = controller.testList;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        height: GetPlatform.isMobile? boxHeight: 637, // 웹이면 변경
        width: GetPlatform.isMobile ? boxWidth : 375, 
        color: Colors.amber,

        child: Stack(
          children: [
            // 상단 바
            Positioned(
              top: 0,
              child: Container(
                width: boxWidth,
                height: 56,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 56,),
                    Text('folder'),
                    GestureDetector(
                      onTap: (){
                        print('+++++++++++++++++++++++++++++++');
                        Get.dialog(
                          // // 커스텀 다이얼로그
                          // Material(
                          //   type: MaterialType.transparency,
                          //   child: Center(
                          //     child: Container(
                          //       width: 250,
                          //       height: 150,
                          //       padding: EdgeInsets.all(5),
                          //       color: Colors.white,
                          //       child: Stack(
                          //         children: [
                          //           Positioned(
                          //             top: 0,
                          //             right: 0,
                          //             child: GestureDetector(
                          //               onTap: () => Get.back(),
                          //               child: Container(
                          //                 width: 20,
                          //                 height: 20,
                          //                 color: Colors.green,
                          //                 child: Center(child: Text('x',style: TextStyle(color: Colors.white),)),
                          //               ),
                          //             ),
                          //           ),
                          //           const Center(
                          //             child: Text('텍스트필드 여기',
                          //               style: TextStyle(
                          //                 fontSize: 15,
                          //                 color: Colors.black,
                          //               ),
                          //             )
                          //           ),
                          //           Align(
                          //             alignment: Alignment.bottomCenter,
                          //             child:InkWell(
                          //               onTap: (){
                          //                 print('리스트 추가 이벤트');
                          //               },
                          //               child: Container(
                          //                 width: 80,
                          //                 height: 30,
                          //                 margin: EdgeInsets.only(bottom: 5),
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(15),
                          //                   color: Colors.blue
                          //                 ),
                          //                 child: Center(child: Text('추가', style: TextStyle(color: Colors.white),)),
                          //               ),
                          //             )
                          //           )
                          //         ],
                          //       ),
                          //     ),
                              
                          //   ),
                          // )
                          CustomDialog(customWidget: Container(width: 100, height: 50, color: Colors.amber,),)
                        );
                      },
                      child: Container(
                        width: 56,
                        color: Colors.green,
                        child: Center(child: Text('+')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // 리스트
            Center(
              child: Container(
                height: 500,
                width: 287,
                color: Colors.blue,
                child: Obx(()=>
                  ReorderableListView(
                    
                    onReorder: (int oldIndex, int newIndex) {
                      // setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveItem = controller.testList.removeAt(oldIndex);
                        controller.testList.insert(newIndex, moveItem);

                        print(controller.testList); // controller에서 리스트 교체하는 함수 필요함
                      // });
                    },
                    onReorderStart: (index) {

                    },
                    onReorderEnd: (index) async{
                      print(index); // 놓여지는 위치
                    },

                    children: controller.testList.map((item) => 
                      Column(
                        key: Key(item),// ReorderableListView 자식 요소로 필수 
                        children: [
                          Container(
                            width: 300,
                            height: 150,
                            color: Colors.white.withOpacity(1),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(item,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          print('$item 수정!?');
                                        },
                                        child: const Text('수정',
                                          style: TextStyle(
                                            color: Palette.lightgray,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: () {
                                          print('$item 삭제!?');
                                        },
                                        child: const Text('삭제',
                                          style: TextStyle(
                                            color: Palette.lightgray
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,)
                        ],
                      )
                    ).toList(),
                  )
                ),
              ),
            ),
            // 광고 섹션
            Positioned(
              bottom: 0,
              child: Container(
                width: boxWidth,
                height: adHeight,
                color: Colors.green,
                child: Text('ADS SECTION'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO 커스텀 다이얼로그 기초 틀 짜고 크기, 내용, 버튼 텍스트 & 함수는 파라미터로 넣어서 사용하도록 구현
class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key, required this.customWidget});

  final Widget customWidget;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 250,
          height: 150,
          padding: EdgeInsets.all(5),
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.green,
                    child: Center(child: Text('x',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
              const Center(
                child: Text('텍스트필드 여기',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                )
              ),
              widget.customWidget,
              Align(
                alignment: Alignment.bottomCenter,
                child:InkWell(
                  onTap: (){
                    print('리스트 추가 이벤트');
                  },
                  child: Container(
                    width: 80,
                    height: 30,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue
                    ),
                    child: Center(child: Text('추가', style: TextStyle(color: Colors.white),)),
                  ),
                )
              )
            ],
          ),
        ),
        
      ),
    );
  }
}