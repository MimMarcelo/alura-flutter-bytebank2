import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/matches.dart';
import '../mocks/mocks.dart';

void main() {
  group("When Dashboard is open", () {

    final mockContactDao = MockContactDao();
    final transactionWebClient = MockTransactionWebClient();

    testWidgets("Should display main image", (WidgetTester tester) async {
      await startApp(tester, mockContactDao, transactionWebClient);
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets("Shold display features", (WidgetTester tester) async {
      await startApp(tester, mockContactDao, transactionWebClient);
      final features = find.byType(FeatureItem);
      expect(features, findsWidgets);
    });

    testWidgets("Should display contacts feature on Dashboard",
        (WidgetTester tester) async {
      await startApp(tester, mockContactDao, transactionWebClient);
//    expect(find.widgetWithIcon(FeatureItem, Icons.people), findsOneWidget);
      final contactsFeatureItem = featureItemMatcher("Contacts", Icons.people);
      expect(contactsFeatureItem, findsOneWidget);
    });

    testWidgets("Should display transfers feature on Dashboard",
        (WidgetTester tester) async {
      await startApp(tester, mockContactDao, transactionWebClient);
//    expect(find.widgetWithIcon(FeatureItem, Icons.monetization_on), findsOneWidget);
      final transfersFeatureItem =
          featureItemMatcher("Transactions", Icons.monetization_on);
      expect(transfersFeatureItem, findsOneWidget);
    });
  });
}
