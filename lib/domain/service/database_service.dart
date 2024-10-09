import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_will_do_it/data/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService{
  static DatabaseService?_databaseService;
  static Database? _database;
  DatabaseService._createInstance();

  String taskTable = 'taskTable';
  String name = 'name';
  String desc = 'desc';
  String tag = 'tag';
  String date = 'date';
  String priority = 'priority';
  String priorityIndex = 'priorityIndex';


  factory DatabaseService() {
    _databaseService ??= DatabaseService._createInstance();
    return _databaseService!;
  }

  // Getter for our database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  // Function to initialize the database
  Future<Database> initializeDatabase() async {
    // Getting directory path for both Android and iOS
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}task.db';

    // Open or create database at a given path.
    var personDatabase = await openDatabase(path, version: 5, onCreate: _createTable);
    return personDatabase;
  }


  void _createTable(Database db, int dbVersion) async {
    if (_database == null) {
      await db.execute(
          'CREATE TABLE $taskTable ('
              '$name TEXT, '
              '$date TEXT, '
              '$desc TEXT, '
              '$tag TEXT, '
              '$priorityIndex INTEGER, '
              '$priority TEXT)'
      );
    }
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM $taskTable ');
    return result;
  }


  Future<List<Map<String, dynamic>>> getTask(String newDate) async {
    Database db = await database;
    var result = await db.rawQuery(
        'SELECT * FROM $taskTable WHERE $date = \'$newDate\' ');
    return result;
  }


  Future<int> insertTask(TaskModel task) async {
    Database db = await database;
    var result = await db.insert(taskTable, task.toMap());

    debugPrint("Person details inserted in the $taskTable.");
    debugPrint("$taskTable contains $result records.");
    return result;
  }


  Future<int> updateTask(TaskModel newTask, TaskModel oldTask) async {
    Database db = await database;

    var result = await db.update(taskTable, newTask.toMap(),
        where: '$date=? and $name=? and $priority=?',
        whereArgs: [oldTask.date, oldTask.name, oldTask.priority]);
    return result;
  }


  Future<int> deleteTask(TaskModel task) async {
    Database db = await database;

    var result = await db.rawDelete(
        'DELETE FROM $taskTable WHERE $date=? and $name=? and $priority=?',
        [task.date, task.name, task.priority]);

    return result;
  }


}