import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.size),
        color: widget.isSelected == true
            ? HexColor('#4E7D96')
            : HexColor('#767680').withOpacity(0.12),
      ),
      margin: EdgeInsets.symmetric(vertical: widget.margin),
      padding: EdgeInsets.all(7),
      height: widget.size,
      width: widget.size,
      child: widget.isSelected == true
          ? SvgPicture.asset(
              'assets/icons/ok_icon.svg',
              color: Colors.white,
              height: 6,
              width: 5,
            )
          : null,
    );
  }
}

class CheckBox extends StatefulWidget {
  final bool isSelected;
  final double margin;
  final double size;

  CheckBox({this.isSelected = false, this.margin = 8.0, this.size = 30.0});

  @override
  CheckBoxState createState() => CheckBoxState();
}
