import 'package:flutter/material.dart';

import 'ExpandedListAnimationWidget.dart';

class DropDown extends StatefulWidget {
  final String title;
  final List<Widget> list;
  final double unitHeight;

  DropDown({
    @required this.title,
    @required this.list,
    this.unitHeight
  });
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool isStrechedDropDown = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Row(children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          isStrechedDropDown = !isStrechedDropDown;
                        }),
                        child: Row(children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: widget.unitHeight * 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Icon(isStrechedDropDown
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down
                          ),
                        ]),
                      ),
                    ],),
                  ),
                  ExpandedSection(
                    expand: isStrechedDropDown,
                    height: 100,
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                        },
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) =>
                            widget.list.elementAt(index),
                      ),
                    ),
                  ),
                ],),
              ),
            ),
          ]
        ),
      ],),
    );
  }
}