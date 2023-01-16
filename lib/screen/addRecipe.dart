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
  @override
  Widget build(BuildContext context) {
    return Material(

      child: Center(
        child: Container(
          width: 330.w,
          height: 820.h,
          color: Colors.green,
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
                      print('추가버튼클릭했음');
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

              // 내용
              Container(
                width: 330.w,
                height: 755.h,
                color: Colors.red,
              ),

            ],
          ),
        ),
      ),
    );
  }
}