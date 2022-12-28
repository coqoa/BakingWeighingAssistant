import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultAlertDialogOneButton extends StatelessWidget{

  late String title;
  late String buttonTitle;
  late Widget contents;
  late Function? confirmFunction;
  DefaultAlertDialogOneButton({required this.title, required this.contents,required this.buttonTitle, this.confirmFunction});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      title: Center(child: Text(title,style: TextStyle(fontFamily:'NotoSansBold',fontSize: 22))),
      content: Container(
        height: 188,
        width: 328,
        child: Column(
          children: [
            Container(
                height: 116,
                child: Center(
                  child: contents
            )),
            Spacer(),    
            Container(
              height: 72,
              decoration: BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(
                  onTap: () async {
                    if(confirmFunction!=null){ confirmFunction!();
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                    child: Container(
                        height: 44,
                        width: 296,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.black,
                        ),    
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0,bottom: 3),
                        child: Center(
                          child: Text(
                            buttonTitle
                            ,style: TextStyle(color: Palette.white,fontFamily:'NotoSansBold',fontSize: 13)
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