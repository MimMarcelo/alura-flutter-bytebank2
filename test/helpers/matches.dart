import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

Future<void> startApp(WidgetTester tester, MockContactDao mockContactDao,
    TransactionWebClient transactionWebClient) {
  return tester.pumpWidget(
    ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: transactionWebClient,
    ),
  );
}

Finder featureItemMatcher(String description, IconData iconData) {
  return find.byWidgetPredicate((widget) {
    if (widget is FeatureItem) {
      return widget.description == description && widget.iconData == iconData;
    }
    return false;
  });
}

Finder textFieldMatcher(String labelText) {
  return find.byWidgetPredicate((widget) {
    if (widget is TextField) {
      return widget.decoration.labelText == labelText;
    }
    return false;
  });
}
