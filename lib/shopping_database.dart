import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Item {
  final int? id;
  final String name;
  final int quantity;
  final bool bought;
  final String date;
  final String shop;
  final String storage;

  const Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.bought,
    required this.date,
    required this.shop,
    required this.storage,
  });

  Item copyWith({
    int? id,
    String? name,
    int? quantity,
    bool? bought,
    String? date,
    String? shop,
    String? storage,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      bought: bought ?? this.bought,
      date: date ?? this.date,
      shop: shop ?? this.shop,
      storage: storage ?? this.storage,
    );
  }

  //convert object to a map for database insertion(?)
  //key must correspond to name of the columns
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'bought': bought ? 1:0,
      'date': date,
      'shop': shop,
      'storage': storage,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      bought: map['bought'] == 1,
      date: map['date'],
      shop: map['shop'],
      storage: map['storage'],
    );
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantity: $quantity, bought: $bought, date: $date, shop: $shop, storage: $storage}';
  }
}

Future<Database> initializeDatabase() async {
  final database = openDatabase(
      join(await getDatabasesPath(), 'shopping_database.db'),
      onCreate: (db, version) {
          return db.execute(
              '''CREATE TABLE items(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT NOT NULL,
                  quantity INTEGER NOT NULL,
                  bought INTEGER NOT NULL,
                  date TEXT,
                  shop TEXT,
                  storage TEXT
              )'''
          );
      },
      version: 1,
  );
  return database;
}

Future<void> insertItem(Item item) async {
  final db = await initializeDatabase();
  await db.insert(
    'items',
    item.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateItem(Item item) async {
  final db = await initializeDatabase();
  await db.update(
    'items',
    item.toMap(),
    where: 'id = ?',
    whereArgs: [item.id],
  );
}

Future<void> deleteItem(int id) async {
  final db = await initializeDatabase();
  await db.delete(
    'items',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<List<Item>> getItems() async {
  final db = await initializeDatabase();
  final List<Map<String, dynamic>> maps = await db.query('items');

  return List.generate(maps.length, (i) {
    return Item(
      id: maps[i]['id'],
      name: maps[i]['name'],
      quantity: maps[i]['quantity'],
      bought: maps[i]['bought'] == 1,
      date: maps[i]['date'],
      shop: maps[i]['shop'],
      storage: maps[i]['storage'],
    );
  });
}