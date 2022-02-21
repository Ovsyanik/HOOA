import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final double margin;
  final String text;
  final Color textColor;
  final Color color;
  final double width;
  final double height;
  final double textSize;
  final Color disabledColor;

  Button({
    @required this.onPressed,
    this.margin = 16.0,
    this.text,
    this.textColor = Colors.white,
    this.color,
    this.width,
    this.height = 50.0,
    this.textSize = 15.0,
    this.disabledColor
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Container(
      height: unitHeight * height,
      width: width == null
          ? size.width / 2 - 24
          : width,
      margin: EdgeInsets.symmetric(vertical: margin),
      child: MaterialButton(
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: disabledColor == null ? BorderSide(
            color: HexColor("#FF844B"),
          ) : BorderSide(
            color: Colors.white,
          ),
        ),
        color: color == null
            ? HexColor('#FF844B')
            : color,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onPressed,
        disabledColor: disabledColor == null
            ? null
            : disabledColor,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: unitHeight * textSize,
          ),
        ),
      ),
    );
  }

}