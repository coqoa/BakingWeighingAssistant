import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/palette.dart';

class Memo extends StatefulWidget {
  Memo({super.key,required this.menuTitle});
  final String menuTitle;

  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String memoContents = '';

  @override
  void initState() {
    super.initState();
    firestore.collection('users').doc(uid).collection(widget.menuTitle).doc('Memo').get().then((value){
      setState(() {
        memoContents = value.data()!['Memo'];
      });
    });
  }

  editMemo(contents)async{
    await firestore.collection('users').doc(uid).collection(widget.menuTitle).doc('Memo').set(
      {'Memo':contents}
    );
  }

  @override
  Widget build(BuildContext context) {

  TextEditingController _textEditingController = new TextEditingController(text: memoContents);

  return  AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      // header:
      title: Center(
        child: Text('memo'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Palette.black,
            fontSize: 25
          ),
        )
      ),
      // main:
      content: SingleChildScrollView(
        child: SizedBox(
          width: 270.w,
          height: 410.h,
          child: Column(
            children: [
              // 메모 입력 공간
              Container(
                height: 350.h,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  maxLength: 500,
                  controller: _textEditingController,
                  onChanged: (value ) {
                    memoContents = value;
                  },
                  autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "enterWithinCharacters".tr,
                    border: InputBorder.none,
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: 20,
                ),
              ),
              //  저장 버튼
              SizedBox(
                height: 50.h,
                child: GestureDetector(
                  child: Center(
                    child: Container(
                      width: 120.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Palette.gray, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('save'.tr,
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
                    editMemo(memoContents);
                    Navigator.of(context).pop();
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