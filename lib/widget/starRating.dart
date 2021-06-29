import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;

  StarRating({this.starCount = 5, this.rating = .0});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    if (index > rating - 1) {
      icon = Icon(
        Icons.star_border,
        size: 14,
        color: HexColor('#262626').withOpacity(0.3),
      );
    } else {
      icon = Icon(
        Icons.star,
        size: 14,
        color:  HexColor('#4E7D96'),
      );
    }
    return InkResponse(
      child: icon,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[ 
        Row(children: List.generate(starCount, (index) => buildStar(context, index))),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            rating.toString(),
            style: TextStyle(
              color: HexColor('#4E7D96'),
              fontSize: 15
            ),
          ),
        )
      ]
    );
  }
}