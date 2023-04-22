import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {

          // sign.dart
          'eMailAddress' : '이메일',
          'password' : '비밀번호',
          'passwordRepeat' : '비밀번호 확인',
          'logIn' : '로그인',
          'register' : '회원가입',
          'dontYouHaveAnAccount' : '계정이 없으세요? ',
          'joinUs' : '회원가입하기',
          'doYouHaveAnAccount' : '계정이 있으세요? ',
          'logIn2' : '로그인하기',
          'orStartWithAnAnonymousAccount' : '일단 회원가입 없이 시작할래요',

          // sign_controller.dart
          'passwordInvalid' : '잘못된 비밀번호 입니다',
          'badlyFormatEmail' : '이메일을 형식에 맞게 입력해주세요',
          'thereIsNoUserRecord' : '회원 정보가 없습니다',
          'anEmailAddressMustBeProvided' : '이메일 주소는 필수 입력사항 입니다',
          'alreadyInUseEmail' : '사용중인 이메일 입니다',
          'atLeast6CharactersPassword' : '비밀번호는 6자 이상으로 작성해주세요',
          'passwordsDoNotMatch' : '패스워드가 맞지 않습니다',

          // menu.dart
          'ifYouStartWithoutLoggingIn' : '회원가입 없이 시작하면',
          'youMayLoseYourData' : '데이터가 삭제될 수도 있습니다',
          'toJoinGrammingTapHere' : 'Gramming에 가입하려면 여기를 눌러주세요!',
          'createMenu' : '메뉴 만들기',
          'create' : '생성',
          'back' : '뒤로',
          'submit' : '확인',
          'createNewMenu' : '새로운 Menu 만들기',
          'edit' : '수정',
          'editRecipe' : '레시피 수정',
          'delete' : '삭제',
          'areYouSureDelete1' : '정말로 ',
          // 타이틀 들어갈 곳
          'areYouSureDelete2' : '를 삭제할까요',
          // 2와 3은 붙여쓰면 됨
          'areYouSureDelete3' : '?',
          'joinUs2' : '회원가입',
          'secession1': '회원탈퇴',
          'secession2': '',
          'secession3': '정말로 탈퇴 하시겠습니까?',
          'translate': '한/영 전환',
          'logout' : '로그아웃',

          // menu_controller.dart
          'error' : '에러',
          'anAlreadyExistingTitle' : '이미 존재하는 제목입니다',
          'pleaseCheckTheTitle' : '제목을 확인해주세요',
          'isAlreadyExistsTitle' : ' 는 이미 존재하는 제목입니다',
          // validation
          'pleaseCheckYourPassword' : '비밀번호를 확인해주세요',
          'passwordDoesNotMatch' : '비밀번호가 일치하지 않습니다',
          'theProviderHasAlreadyBeenLinkedToTheUser' : '이미 연결된 이메일입니다',
          "theProvidersCredentialIsNotValid" : "유효하지 않습니다",
          "theAccountCorrespondingToTheCredentialAlreadyExistsOrIsAlreadyLinkedToAFirebaseUser" : "이미 존재하는 이메일입니다",
          "thisEmailIsInUse" : "이미 사용중인 이메일입니다",
          "pleaseEnterInEmailFormat" : "이메일 형식으로 입력해주세요",
          "pleaseCheckYourPasswordPasswordMustBeDigitsOrMore" : "비밀번호를 확인해주세요 \n 비밀번호는 6자리 이상의 숫자여야 합니다 ",
          "errorCode305" : "Error Code:305",
          
          // recipe.dart
          'memo' : '메모',
          'add' : '추가',
          'addAnewRecipe' : '레시피 추가',
          'ingredient' : '재료',
          'total' : '총 합 ',
          'multiply' : '곱하기',
          'divide' : '나누기',
          // 'edit' : 'Edit', // 위에있음
          'areYouSureDelete' : '정말 삭제하시겠습니까?',
          // 'delete' : 'Delete',// 위에있음

          // recipe_controller.dart
          'isAlreadyExists' : ' 은/는 이미 존재합니다.',
          'pleaseEnterATitle' : '제목을 입력해주세요',

          // add_recipe.dart
          'title' : '제목',

          // calculator.dart
          'calculator' : '계산기',

          // memo.dart
          'save' : '저장', //! 통합?
          'enterWithinCharacters' : '500자 이내로 입력해주세요',
          

        },
        'en_US': {

          // sign.dart
          'eMailAddress' : 'E-Mail Address',
          'password' : 'Password',
          'passwordRepeat' : 'Password Repeat',
          'logIn' : 'Log in',
          'register' : 'Register',
          'dontYouHaveAnAccount' : 'Don’t you have an account? ',
          'joinUs' : 'Join us!',
          'doYouHaveAnAccount' : 'Do you have an account? ',
          'logIn2' : 'Log in!',
          'orStartWithAnAnonymousAccount' : 'or Start with an anonymous account',

          // signController.dart
          'passwordInvalid' : 'password invalid',
          'badlyFormatEmail' : 'badly format email',
          'thereIsNoUserRecord' : 'There is no user record',
          'anEmailAddressMustBeProvided' : 'An email address must be provided',
          'alreadyInUseEmail' : 'already in use email',
          'atLeast6CharactersPassword' : 'at least 6 characters password',
          'passwordsDoNotMatch' : 'Passwords do not match',

          // menu.dart
          'ifYouStartWithoutLoggingIn' : 'If you start without signup,',
          'youMayLoseYourData' : 'you may lose your data',
          'toJoinGrammingTapHere' : 'To join Gramming, tap here!',
          'createMenu' : 'Create menu',
          'create' : 'Create',
          'back' : 'Back',
          'submit' : 'Submit',
          'createNewMenu' : 'Create new menu',
          'edit' : 'Edit',
          'editRecipe' : 'Edit recipe',
          'delete' : 'Delete',
          'areYouSureDelete1' : 'Are you sure delete',
          'areYouSureDelete2' : '',
          'areYouSureDelete3' : '?',
          'joinUs2' : 'Join Us',
          'secession1': 'Secession',
          'secession2': '',
          'secession3': 'Are you sure you want to secession?',
          'logout' : 'Logout',
          'translate': 'Switch to Kor',

          // menu_controller.dart
          'error' : 'ERROR',
          'anAlreadyExistingTitle' : 'An already existing Title',
          'pleaseCheckTheTitle' : 'Please check the Title',
          'isAlreadyExistsTitle' : ' is already exists Title',
          // validation
          'pleaseCheckYourPassword' : 'Please check your password',
          'passwordDoesNotMatch' : 'Password does not match',
          'theProviderHasAlreadyBeenLinkedToTheUser' : 'The provider has already been linked to the user',
          "theProvidersCredentialIsNotValid" : "The provider's credential is not valid",
          "theAccountCorrespondingToTheCredentialAlreadyExistsOrIsAlreadyLinkedToAFirebaseUser" : "The account corresponding to the credential already exists, \nor is already linked to a Firebase User",
          "thisEmailIsInUse" : "This email is in use",
          "pleaseEnterInEmailFormat" : "Please enter in email format",
          "pleaseCheckYourPasswordPasswordMustBeDigitsOrMore" : "Please check your password \nPassword must be 6 digits or more",
          "errorCode305" : "Error Code:305",
          
          // ! sign, menu 스크린, 컨트롤러 확인해고 recipe 하러 넘어가기

          // recipe.dart
          'memo' : 'Memo',
          'add' : 'Add',
          'addAnewRecipe' : 'Add a new Recipe',
          'ingredient' : 'Ingredient',
          'total' : 'Total ',
          'multiply' : 'Multiply',
          'divide' : 'Divide',
          // 'edit' : 'Edit', // 위에있음
          'areYouSureDelete' : 'Are you sure delete ?',
          // 'delete' : 'Delete',// 위에있음

          // recipe_controller.dart
          'isAlreadyExists' : ' is already exists',
          'pleaseEnterATitle' : 'Please enter a Title',

          // add_recipe.dart
          'title' : 'Title',
          // edit_recipe.dart
          // calculator.dart
          'calculator' : 'Calculator',
          // memo.dart
          'save' : 'Save', //! 통합?
          'enterWithinCharacters' : 'Enter within 500 characters',

        },
      };
}

// 검색어
// Text(
// hintText
// snackBar
// 모달