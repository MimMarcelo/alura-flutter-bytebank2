
import 'package:bytebank/screens/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Should display main image", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScaffold(),));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Shold display features", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScaffold()));
    final features = find.byType(FeatureItem);
    expect(features, findsWidgets);
  });
}