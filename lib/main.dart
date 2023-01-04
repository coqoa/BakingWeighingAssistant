
// ignore_for_file: avoid_print

import 'package:bwa/apikey.dart';
import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/add.dart';
import 'package:bwa/screen/menu.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:bwa/screen/sign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FIREBASE_API_KEYS firebaseOptions = FIREBASE_API_KEYS();

  try{
    await Firebase.initializeApp(
      options: FirebaseOptions(
         apiKey: firebaseOptions.apiKey,
        authDomain: firebaseOptions.authDomain,
        projectId: firebaseOptions.projectId,
        storageBucket: firebaseOptions.storageBucket,
        messagingSenderId: firebaseOptions.messagingSenderId,
        appId: firebaseOptions.appId,
        measurementId: firebaseOptions.measurementId
      ),
    );
  }catch(e){
    print(e);
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {

    // ignore: deprecated_member_use
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // 풀스크린앱
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'nanumSquareRound',
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey, 
        scaffoldBackgroundColor: Colors.white,

        // 스테이터스 바 색깔변경? 01/05
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light
        )
      ),

      // 디바이스간 폰트 크기 유지
      builder: (context, child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), 
          child: child!
        );
      },

      home: SafeArea(
        // child: Sign(),
        // child: Menu(),
        child: Recipe(),
      ),
    );
  }
}

