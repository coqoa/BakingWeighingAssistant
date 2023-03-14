
import 'package:bwa/apikey.dart';
import 'package:bwa/config/enum.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
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
  
  // INFO: 광고 관련 변수
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

  // INFO: initState에서 호출, load fail, dimiss, on ad fail 상황에서 재호출
  void _createInterstitialAd() {
    controller.loading();
    InterstitialAd.load(
      adUnitId: adKeys.INTERSTITIAL[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          controller.sucess();
          print('------------------ AD LOADED ------------------ : $ad ');
          interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('------------------ AD ERROR ------------------ : $error');
          _numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ));
    }

  // INFO: 버튼을 누르면 로드되어있는 Ad를 호출하는 메소드
  void _showInterstitialAd() {
    if (interstitialAd == null) {
      print('------------------ interstitialAd is NULL ------------------');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('------------------ SHOWED AD ------------------');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('------------------ DISMISSED AD ------------------ : $ad');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('------------------ FAILED AD ------------------ : AD = $ad, ERROR = $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  @override
  void initState() {
    super.initState();
    controller.loadMenuList();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    print('------------------ DISPOSE AD ------------------');
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
                // INFO: 데이터가 없을 때 출력될 안내 페이지
                if(controller.menuList.length == 0 ){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                  // MAIN:
                  return Theme(
                    // INFO: 드래그 디자인 지우는 부분
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
                        // INFO: 개별 Tile
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
                              
                              // NAV: Tile 하단 버튼
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
                                        // MODAL:
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
                                    
                                    // INFO: DELETE 버튼
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
            
      
            // MODAL: Create 버튼
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

            // MODAL: 설정 버튼
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
                  height: MediaQuery.of(context).size.height -  MediaQuery.of(context).padding.top, //전체화면 - 상태바 크기
                  color: Colors.black.withOpacity(0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 120,
                      height: 50,
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