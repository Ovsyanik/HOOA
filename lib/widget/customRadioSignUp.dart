import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  double width, height;

  CustomRadio(this.width, this.height);

  @override
  createState() => CustomRadioState();
}

class CustomRadioState extends State<CustomRadio> {
  // ignore: deprecated_member_use
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Клиент/Мастер'));
    sampleData.add(new RadioModel(false, 'Заведение'));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.height * 0.22,
      left: widget.width / 20,
      width: widget.width - 40,
      height: widget.height / 5,
      child: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Container(
        height: 50.0,
        width: 50.0,
        child: Center(
          child: Text(
            _item.buttonText,
            style: TextStyle(
              color: _item.isSelected ? Colors.orange : Colors.grey,
                  //fontWeight: FontWeight.bold,
              fontSize: 18.0
            )
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: _item.isSelected ? Colors.orange : Colors.grey),
            borderRadius: const BorderRadius.all(const Radius.circular(15.0),
          ),
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
