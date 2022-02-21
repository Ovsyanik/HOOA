import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/institution.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:meta/meta.dart';

class InstitutionBloc extends Bloc<EventInstitution, InstitutionState> {
  final _db = SqfliteRepository();

  InstitutionBloc() : super(InstitutionState([]));

  @override
  Stream<InstitutionState> mapEventToState(EventInstitution event) async* {
    if (event is GetInstitution) {
      yield* _reloadStaff();
      // } else if(event is GetSelectedStaff) {
      //   _db.getSelectedStaff(event.id);
      //   yield* _reloadStaff();
    } else if (event is EditInstitution) {
      _db.updateInstitution(event.institution);
      yield* _reloadStaff();
    } else if (event is DeleteInstitution) {
      _db.deleteInstitution(event.id);
      yield* _reloadStaff();
    }
  }

  Stream<InstitutionState> _reloadStaff() async* {
    final institutions = await _db.getInstitutions();
    yield InstitutionState(institutions ?? []);
  }
}

@immutable
abstract class EventInstitution {}

class AddInstitution extends EventInstitution {
  final Institution institution;
  AddInstitution(this.institution);
}

class GetInstitution extends EventInstitution {}

class GetSelectedInstitution extends EventInstitution {
  final int id;
  GetSelectedInstitution(this.id);
}

class EditInstitution extends EventInstitution {
  final Institution institution;
  EditInstitution(this.institution);
}

class DeleteInstitution extends EventInstitution {
  final int id;
  DeleteInstitution(this.id);
}

@immutable
class InstitutionState {
  final List<Institution> institutions;

  InstitutionState(this.institutions);
}
