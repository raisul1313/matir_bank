import 'package:matir_bank/model/app_user.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String tableUsers = 'user_table';
  final String tableAccounts = 'account_table';
  final int version = 1;

  static final String userID = 'user_id';
  static final String userName = 'user_name';
  static final String fullName = 'full_name';
  static final String fatherName = 'father_name';
  static final String motherName = 'mother_name';
  static final String address = 'address';
  static final String phoneNumber = 'phone_number';
  static final String birthDate = 'birth_date';
  static final String gender = 'gender';
  static final String password = 'password';

  static final String accountID = 'account_id';
  static final String accountNumber = 'account_number';
  static final String bankName = 'bank_name';
  static final String branch = 'branch';
  static final String amount = 'amount';
  static final String type = 'type';

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('matirBank.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    final textType = 'TEXT NOT NULL';
    final realType = 'REAL NOT NULL';
    await db.execute('''CREATE TABLE $tableUsers ( 
    $userID $idType, 
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

    await db.execute('''CREATE TABLE $tableAccounts ( 
    $accountID $idType,
    $userID $intType,
    $accountNumber $textType,
    $bankName $textType,
    $branch $textType,
    $amount $doubleType,
    $type $textType,
    FOREIGN KEY ($userID) REFERENCES $tableUsers($userID)
    )''');
  }

  Future<bool> register(AppUser appUser) async {
    final db = await instance.database;
    final userID = await db.insert(tableUsers, appUser.toJson());
    return userID != null ? true : false;
  }

  Future<bool> createNewBankAccount(BankAccount bankAccount) async {
    final db = await instance.database;
    final accountID = await db.insert(
      tableAccounts,
      bankAccount.toJson(),
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return accountID != null ? true : false;
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

  Future<AppUser> getUserData(int id) async {
    final db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM $tableUsers WHERE "
        "$userID = '$id'");
    if (res.isNotEmpty) {
      return AppUser.fromJson(res.first);
    } else {
      throw Exception('ID: $id was not found');
    }
  }

  Future<BankAccount> getBankAccountData(int id) async {
    final db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM $tableAccounts WHERE "
        "$accountID = '$id'");
    if (res.isNotEmpty) {
      return BankAccount.fromJson(res.first);
    } else {
      throw Exception('ID: $id was not found');
    }
  }

  Future<List<BankAccount>> getListBankAccountData(int id) async {
    final db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM $tableAccounts WHERE "
        "$userID = '$id'");

    if (res.isNotEmpty) {
      return res.map((json) => BankAccount.fromJson(json)).toList();
    } else {
      throw Exception('ID: $id was not found');
    }
  }

  Future<List<AppUser>> showAllData() async {
    final db = await instance.database;
    final result = await db.query(tableUsers);
    return result.map((json) => AppUser.fromJson(json)).toList();
  }

  Future<int> userDetailsUpdate(AppUser appUser) async {
    final db = await instance.database;
    return db.update(
      tableUsers,
      appUser.toJson(),
      where: '$userID = ?',
      whereArgs: [appUser.userID],
    );
  }

  Future<int> bankAccountDelete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableAccounts,
      where: '$accountID = ?',
      whereArgs: [id],
    );
  }

  Future<int> userDelete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableUsers,
      where: '$userID = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
