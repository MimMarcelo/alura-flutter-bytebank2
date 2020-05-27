
import 'package:bytebank/models/contact.dart';

class Transaction{
  final double value;
  final Contact contact;

  Transaction(this.value, this.contact);

  @override
  String toString() {
    return 'Transaction{_value: $value, _contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> transactionMap = Map();

    transactionMap['value'] = value;
    transactionMap['contact'] = contact.toMap();
    return transactionMap;
  }

  static Transaction from(Map<String, dynamic> transaction){
    return Transaction(transaction['value'], Contact.from(transaction['contact']));

  }
}