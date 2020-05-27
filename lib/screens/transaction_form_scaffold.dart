import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/auth_dialog.dart';
import 'package:bytebank/widgets/response_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionFormScaffold extends StatefulWidget {
  final Contact contact;

  TransactionFormScaffold(this.contact);

  @override
  _TransactionFormScaffoldState createState() =>
      _TransactionFormScaffoldState();
}

class _TransactionFormScaffoldState extends State<TransactionFormScaffold> {
  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Transaction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                widget.contact.account.toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: valueController,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  labelText: "Value",
                  hintText: "0,00",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("Transfer"),
                  onPressed: () {
                    double value = double.tryParse(valueController.text);
                    Transaction transactionToSave =
                        Transaction(value, widget.contact);
                    showDialog(
                        context: context,
                        builder: (contextDialog) {
                          // Mudar o nome do contexto, para que na função interna, seja possível atribuir o context do Scaffold
                          return AuthDialog(
                            onConfirm: (String password) async {
                              Transaction transaction =
                                  await TransactionWebClient.insert(
                                          transactionToSave, password)
                                      .catchError((error) {
                                showDialog(
                                    context: context,
                                    builder: (contextDialog) {
                                      return FailureDialog(error.message);
                                    });
                              }, test: (error) => error is Exception);

                              if (transaction != null) {
                                showDialog(
                                    context: context,
                                    builder: (contextDialog) {
                                      return SuccesDialog(
                                          "Transaction created");
                                    }).then((value) => Navigator.pop(context));
                              } else {
                                print("Transaction not created");
                              }
                            },
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
