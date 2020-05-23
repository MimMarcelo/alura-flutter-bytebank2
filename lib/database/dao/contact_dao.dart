import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContactDao {

  static const String SQL_TABLE = "CREATE TABLE $_TABLE_NAME ("
      "$_ID INTEGER PRIMARY KEY, "
      "$_NAME TEXT, "
      "$_ACCOUNT INTEGER)";

  static const String _TABLE_NAME  = 'contacts';
  static const String _ID  = 'id';
  static const String _NAME  = 'name';
  static const String _ACCOUNT  = 'account';

  static Future<List<Contact>> all() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_TABLE_NAME);

    return _toList(result);
  }

  static Future<int> insert(Contact contact) async {
    final Database db = await getDatabase();
    return db.insert(_TABLE_NAME, _toMap(contact));
  }

  static Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMapping = Map();

    contactMapping[_NAME] = contact.name;
    contactMapping[_ACCOUNT] = contact.account;
    return contactMapping;
  }

  static List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in result) {
      contacts.add(_toObject(row));
    }
    return contacts;
  }

  static Contact _toObject(Map<String, dynamic> row) {
    return Contact(
      row[_ID],
      row[_NAME],
      row[_ACCOUNT],
    );
  }
}
