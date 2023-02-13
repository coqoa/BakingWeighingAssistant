
import 'package:flutter/material.dart';


// BOTTOM ADS
class BottomAdSection extends StatefulWidget {
  const BottomAdSection({super.key});

  @override
  State<BottomAdSection> createState() => _BottomAdSectionState();
}

class _BottomAdSectionState extends State<BottomAdSection> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        // margin: EdgeInsets.only(top: 10),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
        width: 360,
        height: 50,
        color: Colors.blue.withOpacity(0.5),
        child: Center(child: Text('Admob Banner',)),
      )
    );
  }
}