
import 'package:bwa/apikey.dart';
import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../controller/menu_controller.dart';
import '../widget/default_alert_dialog_twobutton.dart';
class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  MenuController controller = MenuController();
  late TextEditingController _textController;
  
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  String title = '';
  String changedTitle = '';
  bool settingClicked = false;
  
  // info: 광고 관련 변수
  InterstitialAd? interstitialAd;
  AD_API_KEYS adKeys = AD_API_KEYS();
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  createMenu(e){
    controller.addMenu(e);
  }

  deleteMenu(e){
    controller.deleteMenu(e);
  }
  editMenu(title, changedTitle){
    controller.editMenu(title, changedTitle);
  }

  // info: initState에서 호출, load fail, dimiss, on ad fail 상황에서 재호출
  void _createInterstitialAd() {
    controller.loading();
    InterstitialAd.load(
      adUnitId: adKeys.INTERSTITIAL[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          controller.sucess();
          interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ));
  }

  // info: 버튼을 누르면 로드되어있는 Ad를 호출하는 메소드
  void _showInterstitialAd() {
    if (interstitialAd == null) {
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  anonymousToPerpetual(){
    String email ='';
    String password = '';
    String passwordCheck = '';

    return showDialog(
      context: context, 
      builder: (_){
        return 
        DefaultAlertDialogTwoButton(
          title: '', 
          contents: Container(
            width: 250.w,
            height: 300.h,
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // info: email
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
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'E-mail',
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    email = value;
                  },
                ),
                // info: password
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
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    password = value;
                  },
                ),
                // info: passwordCheck
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
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                    filled: true,
                    fillColor: Palette.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10,0,10,2),
                    hintText: 'Password Check',
                    hintStyle: TextStyle(
                      fontSize: 15
                    ),
                    counterText: ''
                  ),
                  onChanged: (value){
                    passwordCheck = value;
                  },
                  onSubmitted: ((value) {
                    print('돈');
                  }),
                ),
              ],
            ),
          ),
          leftButtonName: 'Back', 
          leftButtonFunction: (){}, 
          rightButtonName: 'Join us',
          rightButtonFuction:(){

            if(password == passwordCheck){
              controller.anonymousToPerpetual(email, password);
            }else{
              // validation
              print('비밀번호 다름'); // here: 벨리데이션 과정 필요함
            }
          },
        );
      }
    );
  }

  

  @override
  void initState() {
    super.initState();
    print('익명유저');
    print(FirebaseAuth.instance.currentUser);
    controller.loadMenuList();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx((){
              if(controller.requestStatus.value==RequestStatus.SUCCESS){
                // info: 데이터가 없을 때 출력될 안내 페이지
                if(controller.menuList.isEmpty ){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ? 익명 로그인시 출력되는 안내문구
                        if(FirebaseAuth.instance.currentUser?.email == null)
                        Column(
                          children: [
                            Text('Anonymous accounts may lose data',
                              style: TextStyle(
                                fontSize: 17,
                                // fontWeight: FontWeight.w800
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){
                                // here:
                                print(FirebaseAuth.instance.currentUser?.email);
                                anonymousToPerpetual();
                              },
                              child: Text('Please tap here to sign up',
                                style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline
                                  // fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Text('Click the add button to create a new Menu',
                          style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('↘︎',
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.w800
                          ),
                        )
                      ],
                    ),
                  );

                }else{
                  // main:
                  return Theme(
                    // info: 드래그 디자인 지우는 부분
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    
                    child: ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final moveItem = controller.menuList.removeAt(oldIndex);
                        controller.menuList.insert(newIndex, moveItem);
                        controller.dragAndDropMenu();
                      },
                  
                      children: controller.menuList.map((item) => 
                        // info: 개별 Tile
                        Container(
                          key: Key(item),// ReorderableListView 자식 요소로 필수 
                          height: 200.h,
                          margin: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 12,
                                offset: Offset(3.0, 6.0),
                                color: Color.fromRGBO(0, 0, 0, .2),
                              )
                            ]
                          ),
                          child: Stack(
                            children: [
                              // CONTENTS_TITLE:
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    _showInterstitialAd();
                                    controller.moveToMenuDetails(item);
                                  },
                                  child: Container(
                                    color: Palette.white,
                                    height: 200.h,
                                    width: 300,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(item,
                                          style: const TextStyle(
                                            // fontFamily: 'jalnan',
                                            color: Palette.lightblack,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ) 
                              ),
                              
                              // nav: Tile 하단 버튼
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Row(
                                  children: [
                        
                                    // INFO: EDIT 버튼
                                    GestureDetector(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Palette.white,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/images/pencil1.svg', 
                                            color: Palette.gray,
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        title = item;
                                        _textController = TextEditingController(text: title);
                                        // modal:
                                        showDialog(
                                          context: context, 
                                          builder: (_){
                                            return 
                                            DefaultAlertDialogTwoButton(
                                              title: 'Edit', 
                                              contents: SizedBox(
                                                width: 250.w,
                                                height: 100.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const SizedBox(),
                                                    TextField(
                                                      key: GlobalKey(),
                                                      controller: _textController, // 텍스트 기본값 설정 컨트롤러
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      cursorColor: Palette.lightblack,
                                                      cursorHeight: 25,
                                                      maxLength: 20,
                                                      autocorrect: false,
                                                      autofocus: true,
                      
                                                      decoration: const InputDecoration(
                                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                                        filled: true,
                                                        fillColor: Palette.white,
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.fromLTRB(10,0,10,2)
                                                      ),
                                                      
                                                      onChanged: (value){
                                                          setState(() {
                                                            changedTitle = value;
                                                          });
                                                      },
                                                      onSubmitted: (value){
                                                        Navigator.of(context).pop();
                                                        editMenu(title, changedTitle);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              leftButtonName: 'Back', 
                                              leftButtonFunction: (){}, 
                                              rightButtonName: 'Submit',
                                              rightButtonFuction:(){
                                                editMenu(title, changedTitle);
                                              },
                                            );
                                          }
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10,),
                                    
                                    // info: DELETE 버튼
                                    GestureDetector(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: Palette.white,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/images/delete2.svg',
                                            color: Palette.gray,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context, 
                                          builder: (_){
                                            return DefaultAlertDialogTwoButton(
                                              title: 'Delete', 
                                              contents: SizedBox(
                                                width: 250,
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Are you sure delete',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text('\'$item\'?',
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ), 
                                              leftButtonName: 'Back', 
                                              leftButtonFunction: (){}, 
                                              rightButtonName: 'Submit',
                                              rightButtonFuction: (){
                                                // db삭제기능 
                                                deleteMenu(item);
                                              }, 
                                            );
                                          }
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        )
                      ).toList(),
                    ),
                  );
                }
              }else{
                // FREEPOSITION: 광고 로드 되기 전에 출력되는 progressIndicator
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
            
      
            // modal: Create 버튼
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/plus2.svg',
                      color: Palette.black,
                      width: 35,
                      height: 35,
                    ),
                  ),
                ),
                onTap: (){
                  showDialog(
                    context: context, 
                    builder: (_){
                      return DefaultAlertDialogTwoButton(
                        title: 'Create', 
                        contents: SizedBox(
                          width: 250.w,
                          height: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              TextField(
                                key: GlobalKey(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                                cursorColor: Palette.lightblack,
                                cursorHeight: 25,
                                maxLength: 20,
                                autocorrect: false,
                                autofocus: true,
    
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.gray)),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.black)),
                                  filled: true,
                                  fillColor: Palette.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(10,0,10,2)
                                ),
                                
                                onChanged: (value){
                                    setState(() {
                                      title = value;
                                    });
                                },
                                onSubmitted: (v){
                                  Navigator.of(context).pop();
                                  createMenu(title);
                              },
                              ),
                            ],
                          ),
                        ),
                        leftButtonName: 'Back', 
                        leftButtonFunction: (){}, 
                        rightButtonName: 'Submit',
                        rightButtonFuction:(){
                          createMenu(title);
                        },
                      );
                    }
                  );
                },
              ),
            ),

            // modal: 설정 버튼
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/setting2.svg',
                      color: Palette.lightgray,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                onTap: (){
                  setState(() {
                    settingClicked = true;
                  });
                },
              ),
            ),
            if(settingClicked)
            Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    settingClicked = false;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top, // info: 전체화면 - 상태바 크기
                  color: Colors.black.withOpacity(0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    // modal: 회원탈퇴, 로그아웃
                    child: Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Palette.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Palette.gray)
                      ),
                      margin: EdgeInsets.only(bottom: 50, left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // LATE: 언어선택 부분 미구현
                          // ? 익명계정일경우?
                          if(FirebaseAuth.instance.currentUser?.email == null)
                          GestureDetector(
                            onTap: (){
                              FirebaseAuth.instance.signOut();
                              Get.off(Sign());   
                            },
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text('Join us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
                                  ),
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              // modal: 회원탈퇴확인
                              showDialog(
                                context: context, 
                                builder: (_){
                                  return 
                                  DefaultAlertDialogTwoButton(
                                    title: 'Secession', 
                                    contents: SizedBox(
                                      child: Text('Are you sure?',
                                      style: TextStyle(
                                      color: Palette.black,
                                      fontSize: 21
                                    ),),
                                    ),
                                    leftButtonName: ' No ', 
                                    leftButtonFunction: (){}, 
                                    rightButtonName: 'Okay',
                                    rightButtonFuction:(){
                                      controller.secession(); // HERE:
                                    },
                                  );
                                }
                              );
                            },
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text('Secession',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
                                  ),
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              FirebaseAuth.instance.signOut();
                              Get.off(Sign());   
                            },
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text('Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.darkgray,
                                  ),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}