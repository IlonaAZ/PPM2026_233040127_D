import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._(); // private constructor
  static final DbHelper instance = DbHelper._(); // singleton

  static const _dbName = 'catatan.db';
  static const _dbVersion = 1;
  static const tabel = 'catatan';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    final dir = await getDatabasesPath();
    final path = join(dir, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tabel (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            judul       TEXT    NOT NULL,
            isi         TEXT    NOT NULL,
            kategori    TEXT    NOT NULL,
            email       TEXT    NOT NULL,
            dibuat_pada INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // ===== CRUD MENGGUNAKAN MAP =====
  // Ini disesuaikan agar main.dart bisa mengonversi datanya sendiri secara fleksibel

  Future<int> insert(Map<String, Object?> row) async {
    final db = await database;
    return db.insert(tabel, row);
  }

  Future<List<Map<String, Object?>>> getAll() async {
    final db = await database;
    return db.query(tabel, orderBy: 'dibuat_pada DESC');
  }

  Future<int> update(Map<String, Object?> row) async {
    final db = await database;
    final id = row['id'];
    return db.update(
      tabel,
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(tabel, where: 'id = ?', whereArgs: [id]);
  }
}