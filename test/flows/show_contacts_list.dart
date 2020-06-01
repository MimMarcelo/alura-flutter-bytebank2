import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/matches.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets("Should show contacts list scaffold",
      (WidgetTester tester) async {
    await contactsListTest(
        tester, MockContactDao(), MockTransactionWebClient());
  });
}

Future<void> contactsListTest(
    WidgetTester tester,
    MockContactDao mockContactDao,
    MockTransactionWebClient mockTransactionWebClient) async {
  await startApp(tester, mockContactDao, mockTransactionWebClient);
  final dashboardScaffold = find.byType(DashboardScaffold);
  expect(dashboardScaffold, findsOneWidget);

  final contactsFeature = featureItemMatcher("Contacts", Icons.people);
  expect(contactsFeature, findsOneWidget);
  await tester.tap(contactsFeature);
  await tester.pumpAndSettle();

  final contactsListScaffold = find.byType(ContactsListScaffold);
  expect(contactsListScaffold, findsOneWidget);

  verify(mockContactDao.all()).called(1);

  final fab = find.byType(FloatingActionButton);
  expect(fab, findsOneWidget);
}
