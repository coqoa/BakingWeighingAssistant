

import 'package:bwa/screen/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignController extends GetxController{

  final _authentication = FirebaseAuth.instance;

  RxString userEmail = ''.obs;
  RxString userPassword = ''.obs;
  RxString userPasswordRepeat = ''.obs;

  RxString validationResult = ''.obs;

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

  Future<void> validation(errMsg, sign)async {
    if(sign == 'SignIn'){
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

    }else{
      // SIGN UP
      if(userPassword == userPasswordRepeat){
        // 이메일 형식 오류
        if(errMsg == '[firebase_auth/invalid-email] The email address is badly formatted.'){
          validationResult.value = 'badly format email.';
        }
        // 사용중인 이메일
        else if(errMsg == '[firebase_auth/missing-email] An email address must be provided.'){
          validationResult.value = 'An email address must be provided.';
        // 사용중인 이메일
        }
        else if(errMsg == '[firebase_auth/email-already-in-use] The email address is already in use by another account.'){
          validationResult.value = 'already in use email.';
        }
        // 비밀번호 길이
        else if(errMsg == '[firebase_auth/weak-password] Password should be at least 6 characters'){
          validationResult.value = 'at least 6 characters password';
        }
      }else{
        validationResult.value = 'Passwords do not match';
      }
      
    }
    
    // else if(errMsg == ''){
    //   validationResult.value = '';
    // }
    
  }

  Future<void> signIn(sign)async {
    final signinBtnClicked = await _authentication.signInWithEmailAndPassword(
      email: userEmail.value, 
      password: userPassword.value
    ).then((value) {
      if(value.user != null){
        // 로그인 성공
        print('가입완료 -> 이동할 페이지 넣기');
        Get.to(()=> Menu());
        // Get.to(transition: Transition.rightToLeft, Recipe());
      }
    }).catchError((e)async{
      await validation(e.message, sign);

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

  Future<void> signUp(sign)async {
    // 회원가입검증
    try{
      print('user email = ${userEmail.value}');
      print('user password = ${userPassword.value}');
      print('user password repeat = ${userPasswordRepeat.value}');
      print('----------');
      if(userPassword.value == userPasswordRepeat.value){
        final newUser = await _authentication.createUserWithEmailAndPassword(
          email: userEmail.value, 
          password: userPassword.value,
        );
        if(newUser.user != null){
          // print('가입완료 -> 이동할 페이지 넣기');
          Get.to(()=> Menu());
        }
      }else{
        validation('Passwords do not match', sign);
      }

    }catch(e){
      print('e');
      print(e);
      await validation(e.toString(), sign);
    }
  }
}