import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';

class SelectActionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Редактирование данных',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16),
        child: Stack(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: unitHeight * 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: HexColor('#C6C6C8').withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async => await Navigator.pushNamed(
                            context, "/paymentMethods"),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: unitHeight * 8,
                            right: unitHeight * 16,
                          ),
                          trailing: SvgPicture.asset(
                            'assets/icons/arrow.svg',
                            color: HexColor("#262626"),
                            height: unitHeight * 15,
                            width: unitHeight * 15,
                          ),
                          title: Text(
                            "Способы оплаты",
                            style: TextStyle(
                              fontSize: unitHeight * 17,
                              color: HexColor('#262626'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: unitHeight * 8),
                    Container(
                      height: unitHeight * 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: HexColor('#C6C6C8').withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => null,
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: unitHeight * 8,
                            right: unitHeight * 16,
                          ),
                          trailing: SvgPicture.asset(
                            'assets/icons/arrow.svg',
                            color: HexColor("#262626"),
                            height: unitHeight * 15,
                            width: unitHeight * 15,
                          ),
                          title: Text(
                            "Настройки уведомлений",
                            style: TextStyle(
                              fontSize: unitHeight * 17,
                              color: HexColor('#262626'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: unitHeight * 8),
                    Container(
                      height: unitHeight * 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: HexColor('#C6C6C8').withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/callback"),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: unitHeight * 8,
                            right: unitHeight * 16,
                          ),
                          trailing: SvgPicture.asset(
                            'assets/icons/arrow.svg',
                            color: HexColor("#262626"),
                            height: unitHeight * 15,
                            width: unitHeight * 15,
                          ),
                          title: Text(
                            "Условия конфиденциальности",
                            style: TextStyle(
                              fontSize: unitHeight * 17,
                              color: HexColor('#262626'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: unitHeight * 8),
                    Container(
                      margin: EdgeInsets.only(
                        top: unitHeight * 8,
                        left: unitHeight * 8,
                      ),
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<SignUpBloc>(context).institution =
                              null;
                          Navigator.pushNamed(context, "/");
                        },
                        child: Text(
                          "Удалить аккаунт",
                          style: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor('#262626'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Button(
                onPressed: () {},
                text: 'Применить',
                color: HexColor("#FF844B"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
