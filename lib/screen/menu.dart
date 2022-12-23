import 'package:bwa/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late double boxWidth = MediaQuery.of(context).size.width; //
  late double boxHeight = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: GetPlatform.isMobile? boxHeight: 637, // 웹이면 변경
        width: GetPlatform.isMobile ? boxWidth : 375, 
        color: Colors.amber,
        child: Center(
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                color: Colors.red,
              ),
              Container(
                height: 500,
                color: Colors.blue,
              ),
              Container(
                height: 50,
                color: Colors.green,
              ),
            ],
          )
        ),
      ),
    );
  }
}