import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooa/model/Card.dart';
import 'package:hooa/repository/sqfliteRepository.dart';

class CardBloc extends Bloc<EventCard, CardState> {
  final _db = SqfliteRepository();

  CardBloc()
      : super(CardLoaded([
          Card(id: 0, number: "4255 4325 2345 6543", cvv: 299, date: '04/23'),
          Card(id: 0, number: "4255 4325 2345 7653", cvv: 399, date: '05/22'),
          Card(id: 0, number: "5255 5525 2245 6343", cvv: 499, date: '06/25'),
        ]));

  @override
  Stream<CardState> mapEventToState(EventCard event) async* {
    if (event is GetCards) {
      yield* _reloadCards();
    } else if (event is AddCard) {
      _db.addCard(event.card);
      yield* _reloadCards();
    } else if (event is EditCard) {
      _db.updateCard(event.card);
      yield* _reloadCards();
    } else if (event is DeleteCard) {
      _db.deleteCard(event.id);
      yield* _reloadCards();
    }
  }

  Stream<CardState> _reloadCards() async* {
    final cards = await _db.getCards();
    yield CardLoaded(cards);
  }
}

@immutable
abstract class EventCard {}

class AddCard extends EventCard {
  final Card card;
  AddCard(this.card);
}

class GetCards extends EventCard {}

class GetSelectedCard extends EventCard {
  final int id;
  GetSelectedCard(this.id);
}

class EditCard extends EventCard {
  final Card card;
  EditCard(this.card);
}

class DeleteCard extends EventCard {
  final int id;
  DeleteCard(this.id);
}

@immutable
abstract class CardState {
  CardState([List props = const []]);
}

class CardLoaded extends CardState {
  final List<Card> cards;

  CardLoaded(this.cards) : super([cards]);
}
