// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  late List listTest;
  late List listTestKey;
  late List listTestValue;
  String titleA = '';
  String testA = '';
  String testB = '';

  void createRecipe(){
    if(titleA.isNotEmpty){
      print('-========================-');
      print('titleA = $titleA');
      print('listTest = $listTest');
      print('-========================-');
    }else{
      print('TITLE을 채워주세용');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTest = [];
    listTestKey = [];
    listTestValue = [];
  }
  @override
  Widget build(BuildContext context) {

    return Material(

      child: Align( // 키보드올라오면 전체 기장 짧아져야함
        alignment: Alignment.topCenter,
        child: Container(
          // width: 330.w,
          // height: 820.h,
          height: 580.h,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
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
                        child: Center(child: Text('<')),
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
              Container(
                width: 330.w,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 25
                  ),
                  onChanged: (value) => titleA = value,
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
              // 행, 열 기준
              Container(
                width: 330.w,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  border: Border(bottom: BorderSide(width: 1, color: Palette.lightgray))
                ),
                margin: EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 165.w,
                      height: 50.h,
                      // color: Colors.red,
                      child: const Center(child: Text('이름'))
                    ),
                    
                    Container(
                      width: 165.w,
                      height: 50.h,
                      // color: Colors.blue,
                      child: const Center(child: Text('g'))
                    ),
                  ]
                ),
              ),
              // 내용
              Container(
                width: 330.w,
                // height: 700.h,
                height: 310.h,
                // color: Colors.green,
                // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child : ListView.builder(
                  itemCount: listTest.length+2, // 리스트 생성 후에 포커스하려면 +2로 해야하나?
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
                                  testA = value;
                                },
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent),),
                                ),
                                // onSubmitted: (value) => testA = value,
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
                                  testB = value;
                                } ,
                                onSubmitted: ((value) {
                                  // setState(() {
                                  //   listTest.add("{'이름':$testA : '중량':$testB}"); // ADD하는식이 아니라 다른식으로 해야할ㄷ것같은데
                                  // });
                                  print(index);
                                }),
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