import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/widget/itemListStaff.dart';

class StaffPage extends StatefulWidget {
  StaffPageState createState() => StaffPageState();
}

class StaffPageState extends State<StaffPage> {
  StaffBloc _staffBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _staffBloc = BlocProvider.of<StaffBloc>(context);
    // Events can be passed into the bloc by calling dispatch.
    // We want to start loading fruits right from the start.
    _staffBloc.add(GetStaff());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/add.svg',
              color: HexColor("#262626"),
              height: 20,
              width: 20,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pushNamed(context, '/addStaff')
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
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
                  fontSize: 34,
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
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.staff.length,
                      itemBuilder: (context, index) {
                        return ItemListStaff(staff: state.staff[index]);
                      }
                    )
                  );
                },
              ) 
            )
          ],
        ),
      )
    );
  }
}