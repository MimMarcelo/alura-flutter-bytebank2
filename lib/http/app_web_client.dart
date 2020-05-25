import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class AppWebClient {
  static const String SERVER_ADDRESS = "http://192.168.1.135:8080/";

  static Future<List<Transaction>> all() async {
    final Response response = await get("${SERVER_ADDRESS}transactions")
        .timeout(Duration(seconds: 5));
    final List<dynamic> jsonMap = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transaction in jsonMap) {
      Map<String, dynamic> contact = transaction['contact'];
      transactions.add(Transaction(transaction['value'],
          Contact(0, contact['name'], contact['account'])));
    }
    return transactions;
  }
}
