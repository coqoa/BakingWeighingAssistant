import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
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
      title: Center(child: Text(title,style: const TextStyle(fontFamily:'jalnan',fontSize: 22, color: Palette.lightblack))),
      // title: Container(
      //   // color: Colors.red,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: 30,
      //         height: 20,
      //         // color: Colors.green,
      //       ),
      //       Text(
      //         title,
      //         style: const TextStyle(
      //           fontFamily:'jalnan',
      //           fontSize: 22, 
      //           color: Palette.lightblack
      //         )
      //       ),
      //       Container(
      //         width: 30,
      //         // color: Colors.blue,
      //         child: GestureDetector(
      //           child: SvgPicture.asset(
      //             'assets/images/ic_cancel.svg',
      //             color: Palette.lightblack,
      //             width: 24,
      //             height: 24,
      //           ),
      //           onTap: () {
                  
      //           },
      //         ),
      //       ),
      //     ],
      //   )
      // ),
      content: Container(
        height: 188,
        width: 328,
        child: Column(
          children: [
            Container(
                height: 126,
                child: Center(
                  child: contents
            )),
            // const Spacer(),    
            Container(
              height: 62,
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
                        height: 44,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: btnColor,
                        ),    
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                        child: Center(
                          child: Text(buttonTitle
                            ,style: TextStyle(
                              color: btnTextColor,
                              fontFamily: 'jalnan',
                              fontSize: 17
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