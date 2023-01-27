// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key, required this.menuTitle});

  final String menuTitle;

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  String title = '';
  List ingredient = [];
  List weight = [];

  void createRecipe(){
    if(title.isNotEmpty){
      print('-========================-');

      print('title = ${widget.menuTitle}');
      print('title = $title');
      print('ingredient = $ingredient');
      print('weight = $weight');
      print('-========================-');
    }else{
      print('TITLE을 채워주세용');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(

      child: Align( // 키보드올라오면 전체 기장 짧아져야함
        alignment: Alignment.topCenter,
        child: Container(
          height: 580.h,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Palette.white,
                  boxShadow: [
                     BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 0),
                      color: Color.fromRGBO(0, 0, 0, .15),
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Palette.white,
                        child: const Center(child: Text('<')),
                      ),
                    ),
                    Text('ADD'),
                    GestureDetector(
                      onTap: (){
                        createRecipe();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Palette.white,
                        child: Center(child: Text('완료')),
                      ),
                    ),
                  ],
                ),
              ),
              // 타이틀 
              Container(
                width: 330.w,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 25
                  ),
                  onChanged: (value) => title = value,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.transparent),
                    ),
                    hintText: "Title"
                  ),
                ),
              ),
              // 시트 헤더
              Container(
                width: 330.w,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  border: Border(bottom: BorderSide(width: 1, color: Palette.lightgray))
                ),
                margin: EdgeInsets.only(bottom: 4),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 165.w,
                      height: 50.h,
                      child: const Center(child: Text('재료명'))
                    ),
                    SizedBox(
                      width: 165.w,
                      height: 50.h,
                      child: const Center(child: Text('중량'))
                    ),
                  ]
                ),
              ),

              // 시트 바디
              Container(
                width: 330.w,
                height: 310.h,
                // color: Colors.green,
                child : ListView.builder(
                  itemCount: weight.length+1, // 리스트 생성 후에 포커스하려면 +2로 해야하나?
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 165.w,
                              height: 50.h,
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                              ),
                              // color: Colors.red,
                              // child: Center(child: Text(listTest[index]['이름'])),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  // testA = value;
                                  setState(() {
                                    if(ingredient.length <= index){
                                      ingredient.add("");
                                      weight.add("");
                                    }
                                    ingredient[index] = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                ),
                              ),
                            ),
                            
                            Container(
                              width: 165.w,
                              height: 50.h,
                              decoration: const BoxDecoration(
                                border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                              ),
                              // color: Colors.green,
                              // child: Center(child: Text(listTest[index]['중량'])),
              
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  // testB = value;
                                  setState(() {
                                    weight[index] = value;
                                  });
                                } ,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                ),
                              ),
                            ),
                          ]
                        ),
                        const Divider(height: 10,),
                      ],
                    );
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}