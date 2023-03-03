// 계산기 다이얼로그 버튼
import 'package:bwa/controller/recipe_controller.dart';
import 'package:flutter/material.dart';

import '../config/palette.dart';

class MultiflyBtn extends StatefulWidget {
  const MultiflyBtn({super.key, required this.callback, required this.text, required this.textColor});
  final String text;
  final Color textColor;
  final Function callback;

  @override
  State<MultiflyBtn> createState() => _MultiflyBtnState();
}

class _MultiflyBtnState extends State<MultiflyBtn> {

  @override
  Widget build(BuildContext context) {

    double blur =  10;
    Offset distance = Offset(4,4);

    return GestureDetector(
      onTap: (){
        setState(() {
          widget.callback();
        });
      },
      child: Container(
        width: widget.text == 'Enter' ? 200 : 60,
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Palette.neumorphismColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Palette.neumorphismBottomShadow,
              blurRadius: blur,
              offset: distance,
            ),
            BoxShadow(
              color: Palette.neumorphismTopShadow,
              blurRadius: blur,
              offset: -distance,
            ),
          ]
        ),
        child: Center(
          child: Text(widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w900
            ),
          )
        ),
      ),
    );
  }
}

class MultiflyWidget extends StatefulWidget {
  const MultiflyWidget({super.key, required this.menuTitle, required this.listViewIndex, required this.controller, required this.type});
  final String menuTitle;
  final int listViewIndex;
  final RecipeController controller;
  final String type;

  @override
  State<MultiflyWidget> createState() => _MultiflyWidgetState();
}

class _MultiflyWidgetState extends State<MultiflyWidget> {

  String multiflyIndicator = '';
  RecipeController controller = RecipeController();

  void multiflyCount(String s,String recipeTitle, int index){
    setState(() {
      if(s == '<-'){
        // 빼기 구현
        if(multiflyIndicator.isNotEmpty ){
          multiflyIndicator = multiflyIndicator.substring(0, multiflyIndicator.length-1);
        }
      }else if(s == '확인'){
        // 적용하는 코드
        if(multiflyIndicator != ''){
          if(widget.type == 'multiple'){
            widget.controller.multipleValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
          }else{
            widget.controller.divideValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
          }
          
        }
        Navigator.of(context).pop();
      }else if(multiflyIndicator.isEmpty && s=='0'){
      }else if(multiflyIndicator.isEmpty && s=='.'){
      }else if(multiflyIndicator.isEmpty && s.contains('.')){

      }else{
        if(multiflyIndicator.length < 5){
          multiflyIndicator = multiflyIndicator+s;
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
            height: 390,
            width: 230,
            decoration: BoxDecoration(
              color: Palette.neumorphismColor,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Palette.reallightgray,
                      borderRadius: BorderRadius.circular(10),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0,3),
                        ),
                      ]
                    ),
                    child: Center(
                      child: Text(multiflyIndicator,
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MultiflyBtn(text: '7', textColor: Palette.textColorWhite, callback: (){multiflyCount('7',widget.controller.recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '8', textColor: Palette.textColorWhite, callback: (){multiflyCount('8',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '9', textColor: Palette.textColorWhite, callback: (){multiflyCount('9',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MultiflyBtn(text: '4', textColor: Palette.textColorWhite, callback: (){multiflyCount('4',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '5', textColor: Palette.textColorWhite, callback: (){multiflyCount('5',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '6', textColor: Palette.textColorWhite, callback: (){multiflyCount('6',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MultiflyBtn(text: '1', textColor: Palette.textColorWhite, callback: (){multiflyCount('1',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '2', textColor: Palette.textColorWhite, callback: (){multiflyCount('2',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '3', textColor: Palette.textColorWhite, callback: (){multiflyCount('3',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MultiflyBtn(text: '.', textColor: Palette.textColorWhite, callback: (){multiflyCount('.',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: '0', textColor: Palette.textColorWhite, callback: (){multiflyCount('0',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                      MultiflyBtn(text: 'del', textColor: Palette.red, callback: (){multiflyCount('<-',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MultiflyBtn(text: 'Enter', textColor: Palette.blue, callback: (){multiflyCount('확인',widget.controller. recipeList[widget.listViewIndex], widget.listViewIndex);}),
                    ]
                  )
              ],
            ),
          ),
      ),
    );


      // elevation: 3,
  }
}