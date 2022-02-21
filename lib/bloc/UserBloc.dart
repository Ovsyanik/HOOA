import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/user.dart';
import 'package:hooa/repository/sqfliteRepository.dart';
import 'package:meta/meta.dart';

class UserBloc extends Bloc<EventUser, UserState> {
  final _db = SqfliteRepository();

  UserBloc() : super(UserLoaded([]));

  @override
  Stream<UserState> mapEventToState(EventUser event) async* {
    if (event is GetUser) {
      yield* _reloadUser();
      // } else if(event is GetSelectedStaff) {
      //   _db.getSelectedStaff(event.id);
      //   yield* _reloadStaff();
    } else if (event is EditUser) {
      _db.updateUser(event.user);
      yield* _reloadUser();
    } else if (event is DeleteUser) {
      _db.deleteUser(event.id);
      yield* _reloadUser();
    }
  }

  Stream<UserState> _reloadUser() async* {
    //final user = await _db.getUser();
    //yield UserLoaded(user);
  }
}

@immutable
abstract class EventUser {}

class AddUser extends EventUser {
  final User institution;
  AddUser(this.institution);
}

class GetUser extends EventUser {}

class GetSelectedUser extends EventUser {
  final int id;
  GetSelectedUser(this.id);
}

class EditUser extends EventUser {
  final User user;
  EditUser(this.user);
}

class DeleteUser extends EventUser {
  final int id;
  DeleteUser(this.id);
}

@immutable
abstract class UserState {
  UserState([List props = const []]);
}

class UserLoaded extends UserState {
  final List<User> institutions;

  UserLoaded(this.institutions) : super([institutions]);
}
