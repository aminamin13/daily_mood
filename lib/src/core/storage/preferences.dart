import 'package:daily_mood/src/config/helpers.dart';
import 'package:daily_mood/src/features/add_mood/model/mood_modle.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MoodDatabase {
  static final MoodDatabase instance = MoodDatabase._internal();
  static Database? _db;

  MoodDatabase._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final deviceId = await getDeviceId();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mood_database_$deviceId.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE moods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        mood TEXT,
        emoji TEXT,
        note TEXT,
        color int
      )
    ''');
  }

  Future<int> insertMood(MoodEntry entry) async {
    final db = await database;
    return await db.insert(
      'moods',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteMoodById(int id) async {
    final db = await database;
    await db.delete('moods', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllMoods() async {
    final db = await database;
    await db.delete('moods');
  }

  Future<List<MoodEntry>> fetchMoodsByDate(DateTime date) async {
    final db = await database;
    final result = await db.query(
      'moods',
      where: 'date = ?',
      whereArgs: [date.toIso8601String().split('T').first],
    );
    return result.map((e) => MoodEntry.fromMap(e)).toList();
  }

  Future<List<MoodEntry>> fetchAllMoods() async {
    final db = await database;
    final result = await db.query('moods');
    return result.map((e) => MoodEntry.fromMap(e)).toList();
  }
}
