/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConfig {
  static const int _version = 1;
  final log = Logger('DbConfig');
  late Database database;

  Future<void> init() async {
    database = await openDatabase(
        join(await getDatabasesPath(), 'blockchain.db'),
        version: _version,
        onConfigure: onConfigure,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDowngrade,
        onOpen: onOpen,
        singleInstance: true);
  }

  Future<void> onConfigure(Database db) async {
    log.finest('configure');
  }

  Future<void> onCreate(Database db, int version) async {
    log.info('create');
    await db.execute(await rootBundle
        .loadString('packages/localchain/src/db/db_create_tables.sql'));
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    log.finest('upgrade');
  }

  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {
    log.finest('downgrade');
  }

  Future<void> onOpen(Database db) async {
    log.finest('open');
  }
}
