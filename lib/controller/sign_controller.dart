

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController{

  final _authentication = FirebaseAuth.instance;


  // RxString signInUserEmail = ''.obs;
  // RxString signInUserPassword = ''.obs;
  
  // RxString signUpUserEmail = ''.obs;
  // RxString signUpUserPassword = ''.obs;
  // RxString signUpUserPasswordRepeat = ''.obs;

  RxString userEmail = ''.obs;
  RxString userPassword = ''.obs;
  RxString userPasswordRepeat = ''.obs;


  RxString validationResult = ''.obs;

  // RxString signInUserEmailValidationResult = ''.obs;
  // RxString signInUserPasswordValidationResult = ''.obs;

  // RxString signUpUserEmailValidationResult = ''.obs;
  // RxString signUpUserPasswordValidationResult = ''.obs;
  // RxString signUpUserPasswordRepeatValidationResult = ''.obs;

  // RxString passwordValidationResult = 'Fail'.obs;
  // RxBool validationResult = false as RxBool;

  // TODO : validation은 회원가입시에만 하기
  // Future<void> userEmailValidation({email})async {
    
  // }

  // Future<void> passwordValidation({password})async {
  //   if(password.length > 5){
  //     passwordValidationResult.value = 'Pass';
  //   }else{
  //     passwordValidationResult.value = 'Fail';
  //   }
  // }
  Future<void> initValidation()async {
    validationResult.value = '';
  }

  Future<void> textFieldChanged(type, value)async {

    validationResult.value = '';

    if(type == 'userEmail'){ 
      userEmail.value = value;
    }else if (type == 'userPassword'){
      userPassword.value = value;
    }else if (type == 'userPasswordRepeat'){
      userPasswordRepeat.value = value;
    }
  }

  Future<void> validation(errMsg)async {
    print('----------');
    print(errMsg);
    print(validationResult.value);
    print('==========');

    // signin인지 signup인지 검증하는 과정 한번 거치고 , 그 이후 에 조건문으로 분기 (2개의 if문으로 signin signup 분기 -> 
    // sign up은 password 와 passwordRepeat 먼저 비교하고 나머지 검증)
    // 전체적으로 디자인조절 (폰트크기 +@)

    //SIGN IN
    // 패스워드 오류
    if(errMsg == 'The password is invalid or the user does not have a password.'){
      validationResult.value = 'password invalid';
    }
    // 이메일 형식 오류
    else if(errMsg == 'The email address is badly formatted.'){
      validationResult.value = 'badly format email.';
    }
    // 없는 이메일
    else if(errMsg == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
      validationResult.value = 'There is no user record';
    }
    // SIGN UP
    // 이메일 형식 오류
    else if(errMsg == '[firebase_auth/invalid-email] The email address is badly formatted.'){
      validationResult.value = 'badly format email.';
    }
    // 사용중인 이메일
    else if(errMsg == '[firebase_auth/email-already-in-use] The email address is already in use by another account.'){
      validationResult.value = 'already in use email.';
    }
    // 비밀번호 길이
    else if(errMsg == '[firebase_auth/weak-password] Password should be at least 6 characters'){
      validationResult.value = 'at least 6 characters password';
    }
    
    else if(errMsg == ''){
      validationResult.value = '';
    }
    
  }

  Future<void> signIn()async {
    final signinBtnClicked = await _authentication.signInWithEmailAndPassword(
      email: userEmail.value, 
      password: userPassword.value
    ).then((value) {
      if(value.user != null){
        // 로그인 성공
        print('가입완료 -> 이동할 페이지 넣기');
        // Get.to(transition: Transition.rightToLeft, Recipe());
      }
    }).catchError((e)async{
      await validation(e.message);

      // Get.snackbar(
      //   authErrorMsg.value, 
      //   '',
      //   snackPosition: SnackPosition.BOTTOM,
      //   forwardAnimationCurve: Curves.elasticInOut,
      //   reverseAnimationCurve: Curves.easeOut,
      //   duration: const Duration(milliseconds: 1500),
      // );
    });
    print('user email = ${userEmail.value}');
    print('user password = ${userPassword.value}');
    print('==========');

  }

  Future<void> signUp()async {
    // 회원가입검증
    try{
      final newUser = await _authentication.createUserWithEmailAndPassword(
        email: userEmail.value, 
        password: userPassword.value
      );
      if(newUser.user != null){
        print('가입완료 -> 이동할 페이지 넣기');
      }
    }catch(e){
      await validation(e.toString());
    }
    print('user email = ${userEmail.value}');
    print('user password = ${userPassword.value}');
    print('user password repeat = ${userPasswordRepeat.value}');
    print('----------');
  }
}