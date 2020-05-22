import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
//  insert(Contact(0, 'Gabriel', 1002)).then((value) => print(value.toString()));
all().then((value) => print(value.toString()));
}

class ByteBankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )
      ),
      home: DashboardScaffold(),
    );
  }
}


