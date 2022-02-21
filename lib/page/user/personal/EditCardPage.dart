import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/CardBloc.dart';
import 'package:hooa/widget/Button.dart';
import 'package:hooa/widget/MyAppBar.dart';
import 'package:hooa/model/Card.dart' as model;

class EditCardPage extends StatefulWidget {
  final model.Card card;

  EditCardPage({this.card});

  @override
  _EditCardPage createState() => _EditCardPage();
}

class _EditCardPage extends State<EditCardPage> {
  final numberCardController = TextEditingController();
  final dateController = TextEditingController();
  final cvvController = TextEditingController();
  bool isHidden = true;
  bool _checkbox = false;

  @override
  void initState() {
    super.initState();

    numberCardController.text = widget.card.number;
    dateController.text = widget.card.date;
    cvvController.text = widget.card.cvv.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Редактирование карты',
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
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "CVV",
                                hintStyle: TextStyle(
                                  fontSize: unitHeight * 17,
                                  color: HexColor("#262626").withOpacity(0.3),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/eye_close.svg',
                                    height: unitHeight * 20,
                                    width: unitHeight * 20,
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
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _checkbox,
                            onChanged: (value) {
                              setState(() {
                                _checkbox = true;
                              });
                            },
                          ),
                          Text('Удалить карту'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    text: 'Сбросить',
                    textColor: HexColor('#FF844B'),
                    color: HexColor('#F8F7F4'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Button(
                    onPressed: () {
                      CardBloc bloc = BlocProvider.of<CardBloc>(context);
                      if (!_checkbox) {
                        bloc.add(EditCard(new model.Card(
                          id: widget.card.id,
                          number: numberCardController.text,
                          cvv: int.parse(cvvController.text),
                          date: dateController.text,
                          user: widget.card.user,
                        )));
                      } else {
                        bloc.add(DeleteCard(widget.card.id));
                      }
                      Navigator.pop(context);
                    },
                    text: 'Применить',
                    color: HexColor("#FF844B"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberCardController.dispose();
    dateController.dispose();
    cvvController.dispose();

    super.dispose();
  }
}
