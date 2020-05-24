import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsListScaffold extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    transactions.add(Transaction(130, Contact(0, "Marcelo", 1000)));
    transactions.add(Transaction(130, Contact(0, "Ana", 1000)));
    transactions.add(Transaction(130, Contact(0, "João", 1000)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _ListItemTransaction(transactions[index]);
        },
        itemCount: transactions.length,
      ),
    );
  }
}
class _ListItemTransaction extends StatelessWidget {
  final Transaction transaction;

  _ListItemTransaction(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transaction.value.toString(),
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          transaction.contact.name,
        ),
      ),
    );
  }
}
