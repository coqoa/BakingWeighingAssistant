import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/menu.dart';
import 'package:bwa/screen/sign.dart';
import 'package:bwa/widget/default_alert_dialog_twobutton.dart';
import 'package:bwa/widget/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../screen/recipe.dart';
import '../widget/validation.dart';

class MenuController extends GetxController{

  RxList menuList = [].obs;
  Rx<RequestStatus> requestStatus = RequestStatus.EMPTY.obs;
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Validation validation = Validation();

  // * 메뉴 로드
  loadMenuList()async{

    requestStatus.value=RequestStatus.LOADING;

    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((result){
      if(result.data()!=null){
        menuList.value = result.data()?['menuList'];
      }else{
        menuList.value = [];
      }
    });
    requestStatus.value=RequestStatus.SUCCESS;
  }

  // * 메뉴 -> 레시피 이동
  moveToMenuDetails(menuTitle){
    Get.to(()=>Recipe(menuTitle: menuTitle,));
  }

  // * 메뉴 추가
  addMenu(e)async{
    if(e.length > 0){
      if(!menuList.contains(e)){
        // 메뉴리스트에 추가
        menuList.add(e);
        // 메뉴리스트 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({'menuList':menuList});
        // 메모 생성 
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('Memo').set({"Memo":''});
        // 레시피 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('Recipe').set({});
        // 레시피 리스트 생성
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('RecipeList').set({"RecipeList":[]});

      }else{
        // snackbar: 존재하는 타이틀일 경우 처리
        CustomSnackBar().snackBar('error'.tr, "anAlreadyExistingTitle".tr);
      }
    }else{
      // snackbar: title이 공백일 경우 처리
      CustomSnackBar().snackBar('error'.tr, "pleaseCheckTheTitle".tr);
    }
  }

  // * 메뉴 삭제
  deleteMenu(e)async{
    menuList.remove(e);
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({'menuList':menuList});
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('Memo').delete();
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('Recipe').delete();
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(e).doc('RecipeList').delete();
    // firebase는 내부에 있는 모든 doc을 지워줘야 collection을 지울 수 있음
  }

  // * 메뉴 수정
  editMenu(originalTitle, changedTitle)async{
    if(changedTitle.length<1 || originalTitle == changedTitle){
      CustomSnackBar().snackBar('error'.tr, "pleaseCheckTheTitle".tr);
    }else{
      if(!menuList.contains(changedTitle)){
        
        var originalMemo = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('Memo').get();
        var originalRecipe = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('Recipe').get();
        var originalRecipeList = await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('RecipeList').get();

        // 리스트 변경 후 업데이트
        menuList[menuList.indexOf(originalTitle)]=changedTitle;
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({'menuList':menuList});

        // 변경 레시피 : 메모 추가 
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(changedTitle).doc('Memo').set(originalMemo.data()!);
        // 변경 레시피 : 레시피 추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(changedTitle).doc('Recipe').set(originalRecipe.data()!);
        // 변경 레시피 : 레시피 리스트 추가
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(changedTitle).doc('RecipeList').set(originalRecipeList.data()!);

        // 기존데이터 삭제해주기
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('Memo').delete();
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('Recipe').delete();
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection(originalTitle).doc('RecipeList').delete();

      }else{
        CustomSnackBar().snackBar('error'.tr, "'$changedTitle' "+'isAlreadyExistsTitle'.tr); // ! check
      }
    }
  }

  dragAndDropMenu()async{
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({'menuList':menuList});
  }

  // * 탈퇴
  void secession()async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).delete();
    await FirebaseAuth.instance.currentUser?.delete();
    await Get.off(Sign());
  }

  // * 익명로그인
  anonymousToPerpetual(context){
    String email ='';
    String password = '';
    String passwordCheck = '';

    return showDialog(
      context: context, 
      builder: (_){
        return 
        DefaultAlertDialogTwoButton(
          title: '', 
          contents: SizedBox(
            width: 250.w,
            height: 300.h,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // email
                TextField(
                  key: GlobalKey(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Palette.lightblack,
                  cursorHeight: 20,
                  keyboardType:TextInputType.emailAddress,
                  maxLength: 20,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'eMailAddress'.tr,
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    email = value;
                  },
                ),

                // password
                TextField(
                  key: GlobalKey(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Palette.lightblack,
                  cursorHeight: 20,
                  keyboardType:TextInputType.emailAddress,
                  maxLength: 25,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'password'.tr,
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    password = value;
                  },
                ),

                // passwordCheck
                TextField(
                  key: GlobalKey(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Palette.lightblack,
                  cursorHeight: 20,
                  keyboardType:TextInputType.emailAddress,
                  maxLength: 25,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'passwordRepeat'.tr,
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    passwordCheck = value;
                  },
                  onSubmitted: ((value) {
                    if(password == passwordCheck){
                      anonymousToPerpetualValidation(email, password, context);
                    }else{
                      validation.validationSnackBar('pleaseCheckYourPassword'.tr);
                    }
                  }),
                ),
              ],
            ),
          ),
          leftButtonName: 'back'.tr, 
          leftButtonFunction: (){}, 
          rightButtonName: 'submit'.tr,
          rightButtonFuction:(){
            if(password == passwordCheck){
              anonymousToPerpetualValidation(email, password, context);
            }else{
              validation.validationSnackBar('passwordDoesNotMatch'.tr);
            }
          },
        );
      }
    );
  }

  // * 익명로그인 -> 회원가입
  anonymousToPerpetualValidation(emailAddress, password, context)async{
    final credential = EmailAuthProvider.credential(email: emailAddress, password: password);
    try {
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential).then((value){
        Navigator.of(context).pop();
        Get.to(()=> Menu());
        
    });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          validation.validationSnackBar("theProviderHasAlreadyBeenLinkedToTheUser".tr);
          // print("The provider has already been linked to the user.");
          break;

        case "invalid-credential":
          validation.validationSnackBar("theProvidersCredentialIsNotValid".tr);
          // print("The provider's credential is not valid.");
          break;

        case "credential-already-in-use":
          validation.validationSnackBar("theAccountCorrespondingToTheCredentialAlreadyExistsOrIsAlreadyLinkedToAFirebaseUser".tr);
          // print("The account corresponding to the credential already exists, "
          //     "or is already linked to a Firebase User.");
          break;

        case "email-already-in-use":
          validation.validationSnackBar("thisEmailIsInUse".tr);
          // print("This email is in use");
          break;

        case "invalid-email":
          validation.validationSnackBar("pleaseEnterInEmailFormat".tr);
          // print("Please enter in email format");
          break;

        case "weak-password":
          validation.validationSnackBar('pleaseCheckYourPasswordPasswordMustBeDigitsOrMore'.tr);
          // print("weak-password - 비밀번호 6자리 이상형식");
          break;
          
        default:
          validation.validationSnackBar('errorCode305'.tr);
          // print("Unknown error. : ${e.code}");
        
        // + 비밀번호 체크는 메뉴페이지에서 해결
      }
    }
  }

  loading(){
    requestStatus.value=RequestStatus.LOADING;
  }

  sucess(){
    requestStatus.value=RequestStatus.SUCCESS;
  }
}