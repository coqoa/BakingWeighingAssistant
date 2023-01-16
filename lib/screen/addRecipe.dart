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

      child: Stack(
        children: [
          
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300.w,
              height: 800.h,
              color: Colors.red,
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                child: Center(child: Text('<')),
              )
            ),
          ),
        ]
      ),
    );
  }
}