import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/widget/customRadioSignUp.dart';

class SignUpBloc extends BlocBase {
  List<RadioModel> _types = [
    new RadioModel(false, 'Клиент/Мастер'),
    new RadioModel(false, 'Заведение')
  ];

  List<RadioModel> get types => _types;

  int get selectedType => _types.indexWhere((element) => element.isSelected == true);

  StreamController<List<RadioModel>> typeController = BehaviorSubject();
  
  Sink<List<RadioModel>> get sink => typeController.sink;
  Stream<List<RadioModel>> get stream => typeController.stream;

  SignUpBloc() : super(null);

  void selectType(int index) async {
    _types.forEach((element) => element.isSelected = false);
    _types[index].isSelected = true;
    sink.add(_types);
  }


  void dispose() {
    typeController.close();
  }
}
