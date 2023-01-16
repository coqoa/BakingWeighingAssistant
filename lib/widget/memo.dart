import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/palette.dart';

class Memo extends StatefulWidget {
  Memo({super.key, required this.memoOpen, required this.contents});

  dynamic memoOpen;
  late String contents;
  


  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {



  @override
  Widget build(BuildContext context) {

    String contents = widget.contents;
    TextEditingController _textEditingController = new TextEditingController(text: contents);
  return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      title: const Center(
        child: Text('Memo',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Palette.black,
            fontSize: 25
          ),
        )
      ),

      content: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          width: 270.w,
          height: 430.h,
          // color: Colors.red,
          child: Column(
            children: [
              Container(
                height: 370.h,
                color: Colors.green[100],
                //  텍스트 필드 너무 큼, 밑줄 없애고 오토포커스?
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  maxLength: 5000,
                  controller: _textEditingController,
                  onChanged: (value ) {
                    // if(_inputController.text.length>=500) {
                    //   showToast("text500".tr,position:ToastPosition.top);
                    //   _inputController.text=_inputController.text;
                    //   _inputController.selection=TextSelection.collapsed(offset: _inputController.text.length); 
                    // }
                      contents = value;
                  },
                  autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    // counterText: "aaaaaaaaaa",
                    hintText: "Enter within 500 characters",
                    border: InputBorder.none,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: 20,
                ),
              ),
              Container(
                height: 50.h,
                // color: Colors.red[100],
                child: GestureDetector(
                  child: Center(
                    child: Container(
                      width: 120.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Palette.gray, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text('Save',
                          style: TextStyle(
                            color: Palette.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    // setState(() {
                    //   widget.memoOpen = false;
                    // });
                    print(contents); // TODO db로 데이터를 보내봐야 알 것 같음
                  },
                ),
              )
            ],
          ),
        ),
      ),


      elevation: 3,
    );
  }
}