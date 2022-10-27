import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/add.dart';
import 'package:bwa/screen/recipe.dart';
import 'package:bwa/screen/sign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'notosans',
        // brightness: Brightness.light,
        // backgroundColor: Colors.white,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        // primaryColor: Colors.blueGrey,
        // primarySwatch: Colors.blueGrey,
        // scaffoldBackgroundColor: Colors.white,
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Palette.lightyellow,
          body: Center(
            child:Add()
            // child:Recipe()
            // child: Sign(boxRadius:25)
          ),
        ),
      ),
    );
  }
}

