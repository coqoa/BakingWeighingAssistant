

import 'package:bwa/screen/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // 검증 결과 출력 메소드
  Future<void> validation(String errMsg, String sign)async {
    if(sign == 'SignIn'){
      // * 로그인 검증 결과
      // 패스워드 오류
      if(errMsg == 'The password is invalid or the user does not have a password.'){
        validationResult.value = 'passwordInvalid'.tr;
      }
      // 이메일 형식 오류
      else if(errMsg == 'The email address is badly formatted.'){
        validationResult.value = 'badlyFormatEmail'.tr;
      }
      // 없는 이메일
      else if(errMsg == 'There is no user record corresponding to this identifier. The user may have been deleted.'){
        validationResult.value = 'thereIsNoUserRecord'.tr;
      }

    }else{
      // * 회원가입 검증 결과
      if(userPassword == userPasswordRepeat){
        // 이메일 형식 오류
        if(errMsg == '[firebase_auth/invalid-email] The email address is badly formatted.'){
          validationResult.value = 'badlyFormatEmail'.tr;
        }
        // 이메일 입력 요망
        else if(errMsg == '[firebase_auth/missing-email] An email address must be provided.'){
          validationResult.value = 'anEmailAddressMustBeProvided'.tr;
        } 
        // 사용중인 이메일
        else if(errMsg == '[firebase_auth/email-already-in-use] The email address is already in use by another account.'){
          validationResult.value = 'alreadyInUseEmail'.tr;
        }
        // 비밀번호 길이 오류
        else if(errMsg == '[firebase_auth/weak-password] Password should be at least 6 characters'){
          validationResult.value = 'atLeast6CharactersPassword'.tr;
        }
      }else{
        // 틀린 비밀번호
        validationResult.value = 'passwordsDoNotMatch'.tr;
      }
    }
  }

  // 회원가입
  Future<void> signIn(String sign)async {
    await _authentication.signInWithEmailAndPassword(
      email: userEmail.value, 
      password: userPassword.value
    ).then((value) {
      if(value.user != null){Get.to(()=> Menu());}
    }).catchError((e)async{
      await validation(e.message, sign);
    });
  }

  // 회원가입검증
  Future<void> signUp(String sign)async {
    try{
      if(userPassword.value == userPasswordRepeat.value){
        final newUser = await _authentication.createUserWithEmailAndPassword(
          email: userEmail.value, 
          password: userPassword.value,
        );
        if(newUser.user != null){Get.to(()=> Menu());}
      }else{
        validation('Passwords do not match', sign);
      }

    }catch(e){
      print('SIGNUP ERROR = $e');
      // 검증 결과 넣어주는 메소드
      await validation(e.toString(), sign);
    }
  }

  // * 익명로그인
  startAnonymous()async{
    _authentication.signInAnonymously().then((value) => Get.to(()=> Menu()));
  }
}