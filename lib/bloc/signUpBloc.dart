import 'dart:async';
import 'dart:ffi';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/user.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/widget/customRadioSignUp.dart';

class SignUpBloc extends BlocBase {
  List<RadioModel> _types = [
    new RadioModel(false, 'Клиент/Мастер'),
    new RadioModel(false, 'Заведение')
  ];
  User _user;
  Institution _institution;

  final _sqfliteRepository = SqfliteRepository();

  List<RadioModel> get types => _types;

  int get selectedType =>
      _types.indexWhere((element) => element.isSelected == true);

  StreamController<List<RadioModel>> typeController = BehaviorSubject();
  Sink<List<RadioModel>> get sink => typeController.sink;
  Stream<List<RadioModel>> get stream => typeController.stream;

  SignUpBloc(

      ) : super(null);

  void selectType(int index) async {
    _types.forEach((element) => element.isSelected = false);
    _types[index].isSelected = true;
    sink.add(_types);
  }

  Future<int> register({User user, Institution institution}) {
    var id;
    if (selectedType == 0) {
      id = _sqfliteRepository.insertUser(user);
    } else if(selectedType == 1) {
      id = _sqfliteRepository.insertInstitution(institution);
    }
    return id;
  }

  // User signIn({String email, String password}) {
  //   _sqfliteRepository.signIn(email: email, password: password)
  //       .then((value) => value)
  //       .catchError((value) => print('Error: value = $value'));
  // }

  void dispose() {
    typeController.close();
  }
}
