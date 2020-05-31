import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form_scaffold.dart';
import 'package:bytebank/screens/transaction_form_scaffold.dart';
import 'package:bytebank/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ContactsListScaffold extends StatefulWidget {

  final ContactDao contactDao;

  const ContactsListScaffold({@required this.contactDao});

  @override
  _ContactsListScaffoldState createState() => _ContactsListScaffoldState();
}

class _ContactsListScaffoldState extends State<ContactsListScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: widget.contactDao.all(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return LoadingWidget.getCircularLoading();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ListItemContact(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TransactionFormScaffold(contact),
                        ),
                      );
                    },
                  );
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
                  builder: (context) => ContactFormScaffold(contactDao: widget.contactDao,),
                ),
              )
              .then((value) => setState(() => {}));
        },
      ),
    );
  }
}

class _ListItemContact extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ListItemContact(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
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
