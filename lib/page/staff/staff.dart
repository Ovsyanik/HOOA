import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/widget/itemListStaff.dart';

class StaffPage extends StatefulWidget {
  // final Staff staff;

  // StaffPage({this.staff});
  StaffPageState createState() => StaffPageState();
}

class StaffPageState extends State<StaffPage> {
  StaffBloc _staffBloc;

  @override
  void initState() {
    super.initState();
    _staffBloc = BlocProvider.of<StaffBloc>(context);
    _staffBloc.add(GetStaff());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        showLeading: false,
        actions: [
          MyAction('assets/icons/add.svg',
                () => Navigator.pushNamed(context, '/addStaff'),),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Сотрудники',
                style: TextStyle(
                  color: HexColor('#262626'),
                  fontSize: unitHeight * 34,
                  fontWeight: FontWeight.w600 
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: BlocBuilder(
                bloc: _staffBloc,
                builder: (context, state) {
                  return Container(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.staff.length,
                        itemBuilder: (context, index) {
                          return ItemListStaff(staff: state.staff[index]);
                        }
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}