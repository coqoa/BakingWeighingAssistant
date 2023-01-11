import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DefaultAlertDialogOneButton extends StatelessWidget{

  late String title;
  late Widget contents;
  late String buttonTitle;
  late Function? confirmFunction;
  late Color? btnColor;
  late Color? btnTextColor;
  DefaultAlertDialogOneButton({super.key, required this.title, required this.contents,required this.buttonTitle, this.confirmFunction, this.btnColor, this.btnTextColor});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      title: Center(child: Text(title,
        style: const TextStyle(
          // fontFamily:'jalnan',
          fontWeight: FontWeight.bold,
          fontSize: 30, 
          color: Palette.black
        )
      )),
      content: Container(
        width: 328.w,
        height: 208.h,
        child: Column(
          children: [
            Container(
                height: 135.h,
                child: Center(
                  child: contents
            )),
            // const Spacer(),    
            Container(
              height: 68.h,
              decoration: const BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                InkWell(
                  onTap: () async {
                    if(confirmFunction!=null){ confirmFunction!();
                      Navigator.of(context).pop();
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                    child: Container(
                        width: 200.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: btnColor,
                        ),    
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                        child: Center(
                          child: Text(buttonTitle
                            ,style: TextStyle(
                              color: btnTextColor,
                              // fontFamily: 'jalnan',
                              fontSize: 22
                            )
                          ),
                        )
                    )
                  ),
              ],),
            )    
          ],
        ),
      ),
      elevation: 3,
    );
  }
}