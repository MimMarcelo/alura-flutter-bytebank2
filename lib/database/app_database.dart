import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.SQL_TABLE);
    },
    version: 1,
//      onDowngrade: onDatabaseDowngradeDelete,
  );

//  Versão sem async
//  return getDatabasesPath().then((dbPath) {
//    final String path = join(dbPath, 'bytebank.db');
//    return openDatabase(
//      path,
//      onCreate: (db, version) {
//        db.execute("CREATE TABLE contacts ("
//            "id INTEGER PRIMARY KEY,"
//            "name TEXT,"
//            "account INTEGER)");
//      },
//      version: 1,
////      onDowngrade: onDatabaseDowngradeDelete,
//    );
//  });
}
