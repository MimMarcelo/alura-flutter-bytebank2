import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form_scaffold.dart';
import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/matches.dart';
import '../mocks/mocks.dart';
import 'show_contacts_list.dart';

void main() {
  testWidgets("Should save contact", (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    await contactsListTest(tester, mockContactDao, MockTransactionWebClient());

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    final contactFormScaffold = find.byType(ContactFormScaffold);
    expect(contactFormScaffold, findsOneWidget);

    final nameTextField = textFieldMatcher("Full name");
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, "Marcelo Júnior");

    final accountTextField = textFieldMatcher("Account number");
    expect(accountTextField, findsOneWidget);
    await tester.enterText(accountTextField, "1000");

    final createButtom = find.widgetWithText(RaisedButton, "Create");
    expect(createButtom, findsOneWidget);
    await tester.tap(createButtom);
    await tester.pumpAndSettle();

    verify(mockContactDao.insert(Contact(0, "Marcelo Júnior", 1000)));

    expect(find.byType(ContactsListScaffold), findsOneWidget);

    verify(mockContactDao.all());
  });
}

