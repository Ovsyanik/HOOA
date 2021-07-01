import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:meta/meta.dart';

class ServicesBloc extends Bloc<EventServices, ServicesState> {
  final _db = SqfliteRepository();

  ServicesBloc() : super(ServicesLoaded([]));

  @override
  Stream<ServicesState> mapEventToState(EventServices event) async* {
    if(event is GetServices) {
      yield* _reloadServices();
    } else if(event is AddService) {
      _db.addStaff(event.staff);
      yield* _reloadServices();
    }
  }

  Stream<ServicesState> _reloadServices() async* {
    final services = await _db.getServices();
    yield ServicesLoaded(services);
  }
}

@immutable
abstract class EventServices {}

class AddService extends EventServices {
  final Staff staff;
  AddService(this.staff);
}

class GetServices extends EventServices {}

class GetSelectedService extends EventServices {
  final int id;
  GetSelectedService(this.id);
}

@immutable
abstract class ServicesState {
  ServicesState([List props = const []]);
}

class ServicesLoaded extends ServicesState {
  final List<Service> services;

  ServicesLoaded(this.services) : super([services]);
}
