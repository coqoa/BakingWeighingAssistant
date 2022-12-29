import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';

class DefaultAlertDialogTwoButton extends StatelessWidget{

  late String title;
  late Widget contents;
  late Function leftButtonFunction;
  late Function rightButtonFuction;
  late String leftButtonName;
  late String rightButtonName;
  DefaultAlertDialogTwoButton({required this.title, required this.contents, required this.leftButtonFunction,required this.rightButtonFuction,required this.leftButtonName, required this.rightButtonName});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      title: Center(child: Text(title,style: TextStyle(fontFamily:'NotoSansBold',fontSize: 18))),
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
                color: Palette.lightgray,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
              ),
              
              child: Row(children: [
                InkWell(
                  onTap: () {
                    leftButtonFunction();
                  },
                  child: Container(
                      height: 36,
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Palette.white,
                        border: Border.all(color: Palette.lightgray)
                      ),
                      padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                      child: Center(
                        child: 
                        Text(leftButtonName,
                            style: TextStyle(color:Palette.darkgray,fontFamily:'NotoSansBold',fontSize: 13)
                        ),
                      )
                  )
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    rightButtonFuction();
                  },
                    child: Container(
                        height: 36,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.lightblack,
                        ),  
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                        child: Center(
                          child: 
                          Text(
                            rightButtonName
                            ,style: TextStyle(
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13
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