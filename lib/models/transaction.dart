import 'package:bytebank/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;

  Transaction(this.id, this.value, this.contact);

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> transactionMap = Map();

    transactionMap['id'] = id;
    transactionMap['value'] = value;
    transactionMap['contact'] = contact.toMap();
    return transactionMap;
  }

  static Transaction from(Map<String, dynamic> transaction) {
    return Transaction(
        transaction['id'],
        transaction['value'],
        Contact.from(transaction['contact']));
  }
}
