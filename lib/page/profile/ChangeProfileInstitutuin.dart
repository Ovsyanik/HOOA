import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/widget/MyAppBar.dart';

class ChangeProfileInstitutionState extends State<ChangeProfileInstitution>
{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Редактирование заведения',
        actions: [],
      ),
      body: Padding (
        padding: EdgeInsets.all(unitHeight * 8),
      ),
    );
  }

}

class ChangeProfileInstitution extends StatefulWidget {
  @override
  ChangeProfileInstitutionState createState() => ChangeProfileInstitutionState();
}