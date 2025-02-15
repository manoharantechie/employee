import 'package:employee/model/emp_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('empDetails.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE empDetails ( 
  _id INTEGER PRIMARY KEY AUTOINCREMENT, 
  isImportant BOOLEAN NOT NULL,
  empName TEXT NOT NULL,
  role TEXT NOT NULL,
  startDate TEXT NOT NULL,
  endDate NOT NULL,
  time NOT NULL
  )
''');
  }

  Future<EmpDetails> create(EmpDetails todo) async {
    final db = await instance.database;
    final id = await db.insert(empTable, todo.toJson());
    return todo.copy(id: id);
  }

  Future<EmpDetails> readTodo({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      empTable,
      columns: EmpDetailsFields.values,
      where: '${EmpDetailsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return EmpDetails.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<EmpDetails>> readAllemp() async {
    final db = await instance.database;
    const orderBy = '${EmpDetailsFields.time} DESC';
    final result = await db.query(empTable, orderBy: orderBy);

    return result.map((json) => EmpDetails.fromJson(json)).toList();
  }

  Future<int> update({required EmpDetails todo}) async {
    final db = await instance.database;

    return db.update(
      empTable,
      todo.toJson(),
      where: '${EmpDetailsFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      empTable,
      where: '${EmpDetailsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
