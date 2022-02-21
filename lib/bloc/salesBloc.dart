import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/Sale.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/model/service.dart';
import 'package:hooa/repository/sqfliteRepository.dart';

class SalesBloc extends Bloc<EventSales, SalesState> {
  final _db = SqfliteRepository();

  SalesBloc() : super(SalesState([], [], [])) {
    this.add(GetSales());
  }

  @override
  Stream<SalesState> mapEventToState(EventSales event) async* {
    if (event is GetSale) {
      yield* _reloadSales();
    } else if (event is AddSale) {
      _db.addSale(event.sale);
      yield* _reloadSales();
    } else if (event is EditSale) {
      _db.updateSale(event.sale);
      yield* _reloadSales();
    } else if (event is DeleteSale) {
      _db.deleteSale(event.id);
      yield* _reloadSales();
    } else if (event is GetSales) {
      yield* _reloadSales();
    }
  }

  Stream<SalesState> _reloadSales() async* {
    final sales = await _db.getSales();
    List<int> s = [];
    List<int> institutionsId = [];
    for (int i = 0; i < sales.length; i++) {
      s.add(sales[i].service);
      institutionsId.add(sales[i].institution);
    }
    final services = await _db.getServicesById(s);
    final institutions = await _db.getInstitutionsById(institutionsId);
    yield SalesState(sales, services, institutions);
  }
}

@immutable
abstract class EventSales {}

class AddSale extends EventSales {
  final Sale sale;
  AddSale(this.sale);
}

class GetSales extends EventSales {}

class GetSale extends EventSales {
  final int id;
  GetSale(this.id);
}

class EditSale extends EventSales {
  final Sale sale;
  EditSale(this.sale);
}

class DeleteSale extends EventSales {
  final int id;
  DeleteSale(this.id);
}

class SalesState {
  final List<Sale> sales;
  final List<Service> services;
  final List<Institution> institutions;

  SalesState(this.sales, this.services, this.institutions);
}
