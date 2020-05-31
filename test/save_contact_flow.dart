import 'package:bytebank/screens/contact_form_scaffold.dart';
import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matches.dart';

void main() {
  testWidgets("Should save contact", (WidgetTester tester) async {
    await startApp(tester);
    final dashboardScaffold = find.byType(DashboardScaffold);
    expect(dashboardScaffold, findsOneWidget);

    final contactsFeature = featureItemMatcher("Contacts", Icons.people);
    expect(contactsFeature, findsOneWidget);
    await tester.tap(contactsFeature);
    await tester.pumpAndSettle();

    final contactsScaffold = find.byType(ContactsListScaffold);
    expect(contactsScaffold, findsOneWidget);

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

    expect(contactsScaffold, findsOneWidget);
  });
}

