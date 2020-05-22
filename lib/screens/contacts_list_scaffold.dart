import 'package:bytebank/screens/contact_form_scaffold.dart';
import 'package:flutter/material.dart';

class ContactsListScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                "Marcelo Júnior",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text("1845-7"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactFormScaffold(),
                ),
              )
              .then((contact) => {
                debugPrint(contact.toString()),
          }
              );
        },
      ),
    );
  }
}
