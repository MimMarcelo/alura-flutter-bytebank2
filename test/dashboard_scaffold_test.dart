import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should display main image", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScaffold(),
    ));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Shold display features", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScaffold()));
    final features = find.byType(FeatureItem);
    expect(features, findsWidgets);
  });

  testWidgets("Should display contacts feature on Dashboard",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScaffold(),
    ));
//    expect(find.widgetWithIcon(FeatureItem, Icons.people), findsOneWidget);
    final contactsFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, "Contacts", Icons.people));
    expect(contactsFeatureItem, findsOneWidget);
  });

  testWidgets("Should display transfers feature on Dashboard",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScaffold(),
    ));
//    expect(find.widgetWithIcon(FeatureItem, Icons.monetization_on), findsOneWidget);
        final TransfersFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, "Transactions", Icons.monetization_on));
        expect(TransfersFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher(Widget widget, String description, IconData iconData) {
  if (widget is FeatureItem) {
    return widget.description == description &&
        widget.iconData == iconData;
  }
  return false;
}
