import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/CardBloc.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/model/Card.dart' as model;

class AddNewCardPage extends StatefulWidget {
  @override
  _AddNewCardPage createState() => _AddNewCardPage();
}

class _AddNewCardPage extends State<AddNewCardPage> {
  final numberCardController = TextEditingController();
  final dateController = TextEditingController();
  final cvvController = TextEditingController();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Новая карта',
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
                      margin: EdgeInsets.only(top: size.height * 0.015),
                      height: unitHeight * 50,
                      child: TextField(
                        controller: this.numberCardController,
                        decoration: InputDecoration(
                          hintText: "0000 0000 0000 0000",
                          hintStyle: TextStyle(
                            fontSize: unitHeight * 17,
                            color: HexColor("#262626").withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      height: unitHeight * 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: this.dateController,
                              decoration: InputDecoration(
                                hintText: "ММ/ГГ",
                                hintStyle: TextStyle(
                                  fontSize: unitHeight * 17,
                                  color: HexColor("#262626").withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.0025 * 16),
                          Expanded(
                            child: TextField(
                              obscureText: isHidden,
                              controller: this.cvvController,
                              decoration: InputDecoration(
                                hintText: "CVV",
                                hintStyle: TextStyle(
                                  fontSize: unitHeight * 17,
                                  color: HexColor("#262626").withOpacity(0.3),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/eye_close.svg',
                                    height: unitHeight * 15,
                                    width: unitHeight * 15,
                                  ),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onPressed: () =>
                                      setState(() => isHidden = !isHidden),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Button(
                onPressed: () {
                  CardBloc bloc = BlocProvider.of<CardBloc>(context);
                  bloc.add(
                    AddCard(
                      new model.Card(
                          number: numberCardController.text,
                          cvv: int.parse(cvvController.text),
                          date: dateController.text,
                          user: BlocProvider.of<SignUpBloc>(context).user.id),
                    ),
                  );
                  Navigator.pop(context);
                },
                width: size.width - unitHeight * 32,
                text: 'Сохранить',
                color: HexColor("#FF844B"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
