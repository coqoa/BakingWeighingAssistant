

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController{

  final _authentication = FirebaseAuth.instance;

  RxString authErrorMsg = ''.obs;

  RxString signInUserEmail = ''.obs;
  RxString signInUserPassword = ''.obs;
  
  RxString signUpUserEmail = ''.obs;
  RxString signUpUserPassword = ''.obs;
  RxString signUpUserPasswordRepeat = ''.obs;

  RxString signInUserEmailValidationResult = ''.obs;
  RxString signInUserPasswordValidationResult = ''.obs;

  RxString signUpUserEmailValidationResult = ''.obs;
  RxString signUpUserPasswordValidationResult = ''.obs;
  RxString signUpUserPasswordRepeatValidationResult = ''.obs;

  RxString passwordValidationResult = 'Fail'.obs;
  // RxBool validationResult = false as RxBool;

  // TODO : validation은 회원가입시에만 하기
  Future<void> userEmailValidation({email})async {
    
  }

  Future<void> passwordValidation({password})async {
    if(password.length > 5){
      passwordValidationResult.value = 'Pass';
    }else{
      passwordValidationResult.value = 'Fail';
    }
  }
  Future<void> passwordRepeatValidation({passwordRepeat})async {
    
  }



  Future<void> signIn()async {
    final signinBtnClicked = await _authentication.signInWithEmailAndPassword(
      email: signInUserEmail.value, 
      password: signInUserPassword.value
    ).then((value) {
      if(value.user != null){
        // 로그인 성공
        print('GOOOOOOOOOOOOOOOOOOOOOOOD');
      }
    }).catchError((e){
      print(e);
      print(e.message);
      authErrorMsg.value = e.toString();
      Get.snackbar(
        authErrorMsg.value, 
        '',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 1500),
      );
    });
  }

  Future<void> signUp()async {
    // 회원가입검증
    try{
      final newUser = await _authentication.createUserWithEmailAndPassword(
        email: signUpUserEmail.value, 
        password: signUpUserPassword.value
      );
      if(newUser.user != null){
        print('null');
        // Get.to(transition: Transition.rightToLeft, Recipe());
      }
    }catch(e){
      print(e);
      authErrorMsg.value = e.toString();
      Get.snackbar(
        authErrorMsg.value, 
        '',
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 1500),
      );
    }
  }
}