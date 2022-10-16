import 'package:bwa/config/palette.dart';
import 'package:bwa/screen/sign.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(fontFamily: 'carter'),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(
        child: Scaffold(
          backgroundColor: Palette.lightyellow,
          body: Center(
            child: Sign(boxRadius:25)
          ),
        ),
      ),
    );
  }
}

