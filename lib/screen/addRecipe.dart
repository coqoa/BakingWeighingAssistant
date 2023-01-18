// ignore_for_file: avoid_print

import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {

  late List listTest;
  String testA = '';
  String testB = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTest = [];

  }
  @override
  Widget build(BuildContext context) {

    return Material(

      child: Align( // 키보드올라오면 전체 기장 짧아져야함
        alignment: Alignment.topCenter,
        child: Container(
          width: 330.w,
          // height: 820.h,
          height: 520.h,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      color: Colors.blue,
                      child: Center(child: Text('<')),
                    ),
                  ),
                  Text('ADD'),
                  GestureDetector(
                    onTap: (){
                      print('-========================-');
                      print(listTest);
                      print('-========================-');
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.orange,
                      child: Center(child: Text('완료')),
                    ),
                  ),
                ],
              ),
      
              // 행, 열 기준
              Container(
                width: 330.w,
                decoration: BoxDecoration(
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
                height: 400.h,
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
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(width: 0.5, color: Palette.reallightgray))
                              ),
                              // color: Colors.red,
                              // child: Center(child: Text(listTest[index]['이름'])),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                onChanged: (value) => testA = value,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                                  ),
                                ),
                                // onSubmitted: (value) => testA = value,
                              ),
                            ),
                            
                            Container(
                              width: 165.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border(left: BorderSide(width: 0.5, color: Palette.reallightgray))
                              ),
                              // color: Colors.green,
                              // child: Center(child: Text(listTest[index]['중량'])),
              
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                                  ),
                                ),
                                onChanged: (value) => testB = value,
                                onSubmitted: (value){
                                  setState(() {
                                    listTest.add("{'이름':$testA : '중량':$testB}");
                                  });
              
                                },
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