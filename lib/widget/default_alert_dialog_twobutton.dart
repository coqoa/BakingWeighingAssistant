import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';

class DefaultAlertDialogTwoButton extends StatelessWidget{

  late String title;
  late Widget contents;
  late Function leftButtonFunction;
  late Function rightButtonFuction;
  late String leftButtonName;
  late String rightButtonName;
  DefaultAlertDialogTwoButton({super.key, required this.title, required this.contents, required this.leftButtonFunction,required this.rightButtonFuction,required this.leftButtonName, required this.rightButtonName});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      title: Center(child: Text(title,style: const TextStyle(fontSize: 25, color: Palette.lightblack))),
      content: SizedBox(
        height: 188,
        width: 328,
        child: Column(
          children: [
            // contents_main:
            SizedBox(
                height: 133,
                child: Center(
                  child: contents
            )),
            const Spacer(),  
            // contents_footer:  
            Container(
              height: 55,
              decoration: const BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // nav: 좌측 버튼
                InkWell(
                  onTap: () {
                    if(leftButtonFunction!=null){ 
                      leftButtonFunction();
                      Navigator.of(context).pop();
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      height: 36,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Palette.lightgray,
                        border: Border.all(color: Palette.lightgray, width: 2)
                      ),
                      padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                      child: Center(
                        child: 
                        Text(leftButtonName,
                            style: const TextStyle(color:Palette.white,fontSize: 15)
                        ),
                      )
                  )
                ),
                const Spacer(),
                // nav: 우측 버튼
                InkWell(
                  onTap: () async {
                    if(rightButtonFuction!=null){ 
                      rightButtonFuction();
                      // Navigator.of(context).pop();
                    }else{
                      // Navigator.of(context).pop();
                    }
                  },
                    child: Container(
                        height: 36,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.lightblack,
                          border: Border.all(color: Palette.lightblack, width: 2)
                        ),  
                        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                        child: Center(
                          child: 
                          Text(
                            rightButtonName,
                            style: const TextStyle(color:Palette.white,fontSize: 15)
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