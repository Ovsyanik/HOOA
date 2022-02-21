import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/bloc/CardBloc.dart';
import 'package:hooa/page/user/personal/EditCardPage.dart';
import 'package:hooa/widget/ItemListCard.dart';
import 'package:hooa/widget/MyAppBar.dart';

class PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unitHeight = size.height * 0.00125;
    CardBloc _cardBloc = BlocProvider.of<CardBloc>(context);
    _cardBloc.add(GetCards());
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Остальное',
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(unitHeight * 16),
        child: Column(
          children: <Widget>[
            ItemListCard(
              title: "Новая карта",
              unitHeight: unitHeight,
              onTap: () async =>
                  await Navigator.pushNamed(context, "/addNewCard"),
            ),
            BlocBuilder(
              bloc: _cardBloc,
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    return ItemListCard(
                      onTap: () async => await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCardPage(card: state.cards[index]),
                        ),
                      ),
                      unitHeight: unitHeight,
                      title: getTypeCard(state.cards[index].number) +
                          getLastNumberCard(state.cards[index].number),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getLastNumberCard(String num) => num.split(' ')[3];

  String getTypeCard(String num) {
    switch (num.split(' ')[0][0]) {
      case '4':
        return 'Visa ';
        break;
      case '5':
        return 'MasterCard ';
        break;
      default:
        return null;
    }
  }
}