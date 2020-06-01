import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:bytebank/screens/transactions_list_scaffold.dart';
import 'package:flutter/material.dart';

class DashboardScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: LayoutBuilder( // Permite que o SingleChildScrollView ocupe toda altura da tela
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight, // Define a altura da tela
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FeatureItem(
                        Icons.people,
                        "Contacts",
                        onClick: () => _showContactsScaffold(context),
                      ),
                      FeatureItem(
                        Icons.monetization_on,
                        "Transactions",
                        onClick: () => _showTrasactionsScaffold(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showContactsScaffold(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsListScaffold(),
      ),
    );
  }

  _showTrasactionsScaffold(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsListScaffold(),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData iconData;
  final String description;
  final Function onClick;

  const FeatureItem(this.iconData, this.description,
      {@required this.onClick})
      : assert(iconData != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
