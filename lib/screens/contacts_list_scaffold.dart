import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form_scaffold.dart';
import 'package:flutter/material.dart';

class ContactsListScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    contacts.add(Contact(0, "Marcelo Júnior", 1000));
//    contacts.add(Contact(0, "Ana Carolina", 1000));
//    contacts.add(Contact(0, "Rebeca Mattiuci", 1000));
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: all(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Loading data")
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ListItemContact(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text("Unknown error");
        },
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
                  });
        },
      ),
    );
  }
}

class _ListItemContact extends StatelessWidget {
  final Contact contact;

  _ListItemContact(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.account.toString(),
        ),
      ),
    );
  }
}
