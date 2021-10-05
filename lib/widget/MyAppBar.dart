import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;
  final String iconLeading;
  final List<MyAction> actions;

  const MyAppBar({
    this.title,
    this.showLeading = true,
    this.actions,
    this.iconLeading = 'assets/icons/return.svg'
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: unitHeight * 60,
      elevation: 0,
      centerTitle: true,
      title: title != null ? Text(
        title,
        style: TextStyle(
          fontSize: unitHeight * 17,
          fontWeight: FontWeight.w700,
          color: HexColor('#262626'),
        ),
      ) : null,
      leading: showLeading ? IconButton(
        icon: SvgPicture.asset(
          iconLeading,
          color: HexColor("#262626"),
          height: unitHeight * 20,
          width: unitHeight * 20,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () => Navigator.of(context).pop(),
      ) : Container(),
      actions: _getActions(unitHeight),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);

  List<Widget> _getActions(double unitHeight) {
    List<Widget> widgets = [];

    for (int i = 0; i < actions.length; i++) {
      widgets.add(IconButton(
        icon: SvgPicture.asset(
          actions[i].uri,
          color: HexColor("#262626"),
          height: unitHeight * 20,
          width: unitHeight * 20,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: actions[i].callback,
      ));
    }

    return widgets;
  }
}

class MyAction {
  final String uri;
  final Object Function() callback;

  MyAction(this.uri, this.callback);
}