import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRadio extends StatelessWidget {
  final Size size;

  CustomRadio(this.size);

  @override
  Widget build(BuildContext context) {
    final unitHeight = size.height * 0.0013;
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      width: size.width,
      height: unitHeight * 150,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final sampleData = snapshot.data ?? bloc.types;
          return ListView.builder(
            primary: false,
            itemCount: bloc.types.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => bloc.selectType(index),
                child: RadioItem(sampleData[index]),
              );
            },
          );
        }
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    final unitHeight = MediaQuery.of(context).size.height * 0.0013;
    return Container(
      margin: EdgeInsets.only(top: unitHeight * 25),
      child: Container(
        height: unitHeight * 50.0,
        width: unitHeight * 50.0,
        child: Align(
          alignment: Alignment(-0.82, 0),
          child: Text(
            _item.buttonText,
            style: TextStyle(
              color: _item.isSelected
                  ? HexColor("#FF844B")
                  : HexColor('#99262626'),
              fontSize: unitHeight * 17.0
            )
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: _item.isSelected
                ? HexColor("#FF844B")
                : HexColor('#99262626'),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
