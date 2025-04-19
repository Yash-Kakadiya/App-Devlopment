import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../core/app_constants.dart';
import 'user_model.dart';

/// A helper class that manages a common SQLite data for users.
/// This data is shared across all admins.
class DatabaseHelper {
  // Singleton instance.
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  /// Returns the common data instance.
  /// Opens the data if it is not already open.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('matrimony.db'); // Common data file name.
    return _database!;
  }

  /// Initializes the data at the given file path.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Creates the necessary tables in the data.
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    // We'll store booleans as INTEGER values (0 or 1)
    const boolType = 'INTEGER NOT NULL';

    // Create the users table.
    await db.execute('''
      CREATE TABLE ${UserModel.tableName} (
        $ID $idType,
        $NAME $textType,
        $EMAIL $textType,
        $PASSWORD $textType,
        $PHONE $textType,
        $GENDER $textType,
        $BIRTHDATE $textType,
        $AGE $textType,
        $HEIGHT $textType,
        $WEIGHT $textType,
        $HOBBIES $textType,
        $EDUCATION $textType,
        $OCCUPATION $textType,
        $EMPLOYED_IN $textType,
        $INCOME $textType,
        $MARITAL_STATUS $textType,
        $MOTHER_TONGUE $textType,
        $RELIGION $textType,
        $COUNTRY $textType,
        $STATE $textType,
        $CITY $textType,
        $ISFAVORITE $boolType
      )
    ''');
  }

  /// Inserts a new row into the [UserModel.tableName] table.
  Future<int> createUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(UserModel.tableName, row);
  }

  /// Retrieves a single user by [id] from the data.
  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await instance.database;
    final result = await db.query(
      UserModel.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  /// Retrieves all users from the data.
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    return await db.query(UserModel.tableName);
  }

  /// Updates the user with the given [id] using [row] data.
  Future<int> updateUser(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update(
      UserModel.tableName,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Deletes the user with the given [id] from the data.
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      UserModel.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Closes the data.
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
