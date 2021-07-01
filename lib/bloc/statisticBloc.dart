import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class StatisticBloc extends BlocBase {
  int _selectedIndexButton = 0;

  int get selectedIndexButton => _selectedIndexButton;

  StreamController<int> _buttonController = BehaviorSubject();
  Sink<int> get _sink => _buttonController.sink;
  Stream<int> get stream => _buttonController.stream;

  StatisticBloc() : super(null);

  void selectButton(int index) async {
    _selectedIndexButton = index;
    _sink.add(index);
  }

  void dispose() {
    _buttonController.close();
  }
}