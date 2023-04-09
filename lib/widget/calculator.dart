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

    return Material(
       color: Colors.transparent,
      child: Ink(
        width: widget.text == 'Enter' ? 200 : 80,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
        child: InkWell(
          highlightColor: Colors.orange,
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            setState(() {
              widget.callback();
            });
          },
          
          child: Center(
            child: Text(widget.text,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w900
              ),
            )
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
        //  입력값 삭제 버튼
        if(multiflyIndicator.isNotEmpty ){
          multiflyIndicator = multiflyIndicator.substring(0, multiflyIndicator.length-1);
        }
      }else if(s == '확인'){
        //  확인 버튼
        if(multiflyIndicator != ''){
          if(widget.type == 'multiple'){
            // * 곱하기
            widget.controller.multipleValueUpdate(widget.menuTitle, recipeTitle, index, multiflyIndicator);
          }else{
            // * 나누기
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
          height: 405,
          width: 240,
          padding: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
            color: Palette.neumorphismColor,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // header:
              Container(
                width: 230,
                height: 110,
                padding: EdgeInsets.only(left: 20, right: 10),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Calculator',
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 21,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    //  입력창
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(widget.type == 'multiple' ? 'x $multiflyIndicator' : '/ $multiflyIndicator g',
                        style: TextStyle(
                          color: Palette.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    //  연산 결과
                    Align(
                      alignment: Alignment.centerRight,
                      // child: Text('연산결과',
                      child: Text(
                        multiflyIndicator.isNotEmpty 
                        ? widget.type == 'multiple'
                          ? '${widget.controller.recipeWeightTotal[widget.listViewIndex]*(double.parse(multiflyIndicator))} g'
                          : '${(widget.controller.recipeWeightTotal[widget.listViewIndex]~/double.parse(multiflyIndicator))} ea'
                        : '',
                        style: TextStyle(
                          color: Palette.lightgray,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                )
              ),

              // main:
              Container(
                height: 255,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Palette.reallightgray),
                  )
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}