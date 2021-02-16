import 'package:book/models/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  DbHelper.internal();

  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) return _db;
    String path = join(await getDatabasesPath(), "gallery.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int v) async {
      await db.execute(
          "create table books(id integer primary key autoincrement, name varchar(50),photo varchar(220),quantity integer)");
      await db.execute(
          "INSERT INTO books ('name', 'photo', 'quantity') values (?, ?, ?)",
          ["الزقوم", "assets/images/book1.jpg", 10]);
      await db.execute(
          "INSERT INTO books ('name', 'photo', 'quantity') values (?, ?, ?)",
          ["Flutter for Beginners", "assets/images/fluuter_beginners.png", 12]);
      await db.execute(
          "INSERT INTO books ('name', 'photo', 'quantity') values (?, ?, ?)", [
        "فلسفة الترجمة",
        "assets/images/Book_translation_philosophy.jpg",
        6
      ]);
      await db.execute(
          "INSERT INTO books ('name', 'photo', 'quantity') values (?, ?, ?)",
          ["قوة كلمة لماذا", "assets/images/book2.jpg", 3]);
    });
    return _db;
  }

  Future<int> createBook(Book book) async {
    Database db = await createDatabase();
    return db.insert("books", book.toMap());
  }

  Future<List> fetchBooks() async {
    Database db = await createDatabase();
    return db.query("books");
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete("books", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateQuantity(Book book) async {
    Database db = await createDatabase();
    return await db.rawUpdate("Update books SET quantity = ? WHERE id = ?",
        [book.quantity - 1, book.id]);
  }
}
