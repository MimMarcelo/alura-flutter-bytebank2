import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp(contactDao: ContactDao(), transactionWebClient: TransactionWebClient(),));
//  insert(Contact(0, 'Gabriel', 1002)).then((value) => print(value.toString()));
//all().then((value) => print(value.toString()));
}

class ByteBankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  ByteBankApp({@required this.contactDao, @required this.transactionWebClient}); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        title: 'ByteBank',
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary,
            )
        ),
        home: DashboardScaffold(),
      ),
    );
  }
}


