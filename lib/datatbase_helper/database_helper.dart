/*import 'package:flutter/foundation.dart';
import 'package:matir_bank/model/app_user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class UserDatabase {
  static Database? _db;

  static const String dbName = 'test.db';
  static const String tableUser = 'user';
  static const int version = 1;

  static const String columnUserID = 'user_id';
  static const String columnUserName = 'user_name';
  static const String columnPassword = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
    }
    return _db;
  }

  // crete DB on local
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("DATABASE LOCATION: " + documentsDirectory.path);
    }
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  //table create to DB
  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        " $columnUserID TEXT, "
        " $columnUserName TEXT, "
        " $columnPassword TEXT, "
        " PRIMARY KEY ($columnUserID)"
        ")");
  }

  //to save data from object model class
  Future<int> saveData(AppUser user) async {
    var dbClient = await db;
    var response = await dbClient!.insert(tableUser, user.toMap());
    return response;
  }

  Future<AppUser?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $tableUser WHERE "
        "$columnUserID = '$userId' AND "
        "$columnPassword = '$password'");

    if (res.isNotEmpty) {
      return AppUser.fromMap(res.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var dbClient = await db;
    var res = await dbClient!.query(tableUser);
    return res;
  }

  Future getUserData() async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $tableUser");
    print("result user data $res");
    print("result user data " + res.toString());
    List list = res.toList().map((c) => AppUser.fromMap(c)).toList();
    return list[0];
  }
}*/

import 'dart:ffi';

import 'package:matir_bank/model/app_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String tableUsers = 'user_details';

  static final String id = 'id';
  static final String userName = 'user_name';
  static final String fullName = 'full_name';
  static final String fatherName = 'father_name';
  static final String motherName = 'mother_name';
  static final String address = 'address';
  static final String phoneNumber = 'phone_number';
  static final String birthDate = 'birth_date';
  static final String gender = 'gender';
  static final String password = 'password';

  static final String accountNumber = 'account_number';
  static final String branch = 'branch';
  static final String amount = 'amount';
  static final String type = 'type';

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createTable);
  }

  Future<void> createTable(Database db, int version) async {
    _createUserTable;
    _createBankAccountTable;
  }

  Future _createUserTable(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''CREATE TABLE $tableUsers ( 
    $id $idType, 
    $userName $textType,
    $fullName $textType,
    $fatherName $textType,
    $motherName $textType,
    $address $textType,
    $phoneNumber $textType,
    $birthDate $textType,
    $gender $textType,
    $password $textType
    )''');
  }

  Future _createBankAccountTable(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INT NOT NULL';
    await db.execute('''CREATE TABLE $tableUsers ( 
    $id $idType, 
    $accountNumber $textType,
    $branch $textType,
    $amount $textType,
    $type $textType,
    PRIMARY KEY ($id),
    )''');
  }

  Future<bool> register(AppUser appUser) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, appUser.toJson());
    return id != null ? true : false;
  }

  Future<AppUser> getLoginUser(String userNameDB, String passwordDB) async {
    final db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM $tableUsers WHERE "
        "$userName = '$userNameDB' AND "
        "$password = '$passwordDB'");

    if (res.isNotEmpty) {
      return AppUser.fromJson(res.first);
    } else {
      throw Exception('Name: $userNameDB or Pass: $passwordDB was not found');
    }
  }

  Future<AppUser> getUserData(int userID) async {
    final db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM $tableUsers WHERE "
        "$id = '$userID'");

    if (res.isNotEmpty) {
      return AppUser.fromJson(res.first);
    } else {
      throw Exception('ID: $userID was not found');
    }
  }

  Future<List<AppUser>> showAllData() async {
    final db = await instance.database;
    final result = await db.query(tableUsers);
    return result.map((json) => AppUser.fromJson(json)).toList();
  }

  Future<int> update(AppUser appUser) async {
    final db = await instance.database;
    return db.update(
      tableUsers,
      appUser.toJson(),
      where: '$id = ?',
      whereArgs: [appUser.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableUsers,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
