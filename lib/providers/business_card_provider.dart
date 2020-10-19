import 'package:e_card/models/business_card.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BusinessCardProvider with ChangeNotifier {
  Database db;
  List<BusinessCard> cardList;

  BusinessCardProvider() : cardList = [];

  Future open() async {
    db = await openDatabase(
      'e_card.db',
      version: 1,
      onCreate: (db, version) async => await db.execute('''
      create table $businessCardsTable (
        id integer primary key,
        name text not null,
        email text not null,
        phone text not null,
        company text not null,
        address text not null,
        site text not null
      )
    '''),
    );
  }

  Future insert(BusinessCard card) async {
    card.id = await db.insert(businessCardsTable, card.toMap());
    cardList.add(card);
    notifyListeners();
    return card;
  }

  Future getCards() async {
    final maps = await db.query(
      businessCardsTable,
      columns: ['name', 'email', 'phone', 'company', 'address', 'site'],
    );

    if (maps.length > 0)
      cardList = maps.map((map) => BusinessCard.fromMap(map)).toList();

    notifyListeners();
  }

  Future delete(int id) async {
    await db.delete(businessCardsTable, where: "id = ?", whereArgs: [id]);
    notifyListeners();
  }

  Future close() async => db.close();
}
