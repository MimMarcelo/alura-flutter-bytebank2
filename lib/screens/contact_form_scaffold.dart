import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContactFormScaffold extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    hintText: "Marcelo Figueiredo Barbosa Júnior",
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: "Account number",
                    hintText: "1845",
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.maxFinite, // Ocupar todo espaço disponível
                  child: RaisedButton(
                    child: Text("Create"),
                    onPressed: () {
                      final String name = _nameController.text;
                      final int account = int.parse(_accountController.text);
                      final Contact contact = Contact(0, name, account);
                      _save(contact, dependencies.contactDao, context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Contact contact, ContactDao contactDao, BuildContext context) async{
    await contactDao.insert(contact);
    Navigator.pop(context);
  }
}
