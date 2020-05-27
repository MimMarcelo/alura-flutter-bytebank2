import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class TransactionsListScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body:
        FutureBuilder<List<Transaction>>(
          future: TransactionWebClient.all(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){

              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return LoadingWidget.getCircularLoading();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Transaction> transactions = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return _ListItemTransaction(transactions[index]);
                  },
                  itemCount: transactions.length,
                );
                break;
            }
            return Text("Nothing to show");
          },
        )

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
