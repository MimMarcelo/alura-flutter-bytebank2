import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute("CREATE TABLE contacts ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "account INTEGER)");
    }, version: 1);
  });
}

Future<int> insert(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMapping = Map();

//    contactMapping['id'] = contact.id; // O SQLite se encarrega de atualizar
    contactMapping['name'] = contact.name;
    contactMapping['account'] = contact.account;

    return db.insert('contacts', contactMapping);
  });
}

Future<List<Contact>> all() {
  return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = List();
      for (Map<String, dynamic> map in maps) {
        contacts.add(Contact(
          map['id'],
          map['name'],
          map['account'],
        ));
      }
      return contacts;
    });
  });
}
