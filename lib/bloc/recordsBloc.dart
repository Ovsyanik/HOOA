import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/record.dart';
import 'package:hooa/repository/sqfliteRepository.dart';

class RecordsBloc extends Bloc<EventRecords, RecordsState> {
  final _db = SqfliteRepository();

  RecordsBloc() : super(RecordLoaded([]));

  @override
  Stream<RecordsState> mapEventToState(EventRecords event) async* {
    if(event is GetRecords) {
      yield* _reloadRecords();
    } else if(event is AddRecord) {
      _db.addRecord(event.record);
      yield* _reloadRecords();
    }
  }

  Stream<RecordsState> _reloadRecords() async* {
    final records = await _db.getRecords();
    yield RecordLoaded(records);
  }
}


@immutable
abstract class EventRecords {}

class GetRecords extends EventRecords {
  final DateTime _dateTime;
  
  GetRecords(this._dateTime);
}

class AddRecord extends EventRecords {
  final Record record;

  AddRecord(this.record);
}


@immutable
abstract class RecordsState {
  RecordsState([List props = const []]);
}

class RecordLoaded extends RecordsState {
  final List<Record> records;

  RecordLoaded(this.records) : super([records]);
}

