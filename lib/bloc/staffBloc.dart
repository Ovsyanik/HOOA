import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/staff.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:meta/meta.dart';

class StaffBloc extends Bloc<EventStaff, StaffState> {
  final _db = SqfliteRepository();

  StaffBloc() : super(StaffLoaded([]));

  @override
  Stream<StaffState> mapEventToState(EventStaff event) async* {
    if(event is GetStaff) {
      yield* _reloadStaff();
    // } else if(event is GetSelectedStaff) {
    //   _db.getSelectedStaff(event.id);
    //   yield* _reloadStaff();
    } else if(event is AddStaff) {
      _db.addStaff(event.staff);
      yield* _reloadStaff();
    }
  }

  Stream<StaffState> _reloadStaff() async* {
    final staff = await _db.getStaff();
    yield StaffLoaded(staff);
  }
}

@immutable
abstract class EventStaff {}

class AddStaff extends EventStaff {
  final Staff staff;
  AddStaff(this.staff);
}

class GetStaff extends EventStaff {}

class GetSelectedStaff extends EventStaff {
  final int id;
  GetSelectedStaff(this.id);
}

@immutable
abstract class StaffState {
  StaffState([List props = const []]);
}

class StaffLoaded extends StaffState {
  final List<Staff> staff;

  StaffLoaded(this.staff) : super([staff]);
}
