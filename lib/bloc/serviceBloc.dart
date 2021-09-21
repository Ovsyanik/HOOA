import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/categoryService.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:meta/meta.dart';

class ServicesBloc extends Bloc<EventServices, ServicesState> {
  final _db = SqfliteRepository();

  ServicesBloc() : super(ServicesState([], [], null)) {
    this.add(GetServices());
  }

  @override
  Stream<ServicesState> mapEventToState(EventServices event) async* {
    if(event is GetServices) {
      yield* _reloadServices();
    } else if(event is AddService) {
      _db.addService(event.service);
      yield* _reloadServices();
    } else if(event is DeleteService) {
      _db.deleteService(event.id);
      yield* _reloadServices();
    } else if(event is ChangeService) {
      _db.updateService(event.service);
      yield* _reloadServices();
    } else if(event is GetServicesById) {
      final _categories = await _db.getCategoryServices();
      final _services = await _db.getServicesById(event.servicesId);
      yield ServicesState(_services, _categories, null);
    }
  }

  Stream<ServicesState> _reloadServices() async* {
    final _categories = await _db.getCategoryServices();
    final _services = await _db.getServices();
    yield ServicesState(_services, _categories, null);
  }
}

@immutable
abstract class EventServices {}

class AddService extends EventServices {
  final Service service;
  AddService(this.service);
}

class GetServices extends EventServices {}

class GetSelectedService extends EventServices {
  final int id;
  GetSelectedService(this.id);
}

class DeleteService extends EventServices {
  final int id;
  DeleteService(this.id);
}

class ChangeService extends EventServices {
  final Service service;
  ChangeService(this.service);
}

class ServicesState {
  final List<Service> services;
  final List<CategoryService> categories;
  final Service service;

  ServicesState(this.services, this.categories, this.service);
}

class GetServicesById extends EventServices {
  final List<int> servicesId;

  GetServicesById(this.servicesId);
}
