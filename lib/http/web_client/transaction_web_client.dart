
import 'dart:convert';

import 'package:bytebank/http/app_web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient{
  static const String TRANSACTIONS_URL = "${AppWebClient.SERVER_ADDRESS}transactions/";
  static const Map<int, String> _httpErrors = {
    400: "There was an error submitting transaction",
    401: "Authentication failed",
    409: "Transaction always exists",
  };

  Future<List<Transaction>> all() async {
    final Response response =
    await get(TRANSACTIONS_URL).timeout(Duration(seconds: 5));
    final List<dynamic> jsonMap = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transaction in jsonMap) {
      transactions.add(Transaction.from(transaction));
    }
    return transactions;
  }

  Future<Transaction> insert(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toMap());

//    await Future.delayed(Duration(seconds: 10));

    final Response response = await post(
      TRANSACTIONS_URL,
      headers: {
        "Content-type": "application/json",
        "password": password,
      },
      body: transactionJson,
    );

    if(response.statusCode >= 300){
      throw Exception(_getError(response.statusCode));
    }

    return Transaction.from(jsonDecode(response.body));
  }

  String _getError(int statusCode) {
    if(_httpErrors.containsKey(statusCode)) {
      return _httpErrors[statusCode];
    }
    return "Unknown error";
  }
}