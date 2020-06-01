import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:bytebank/screens/transaction_form_scaffold.dart';
import 'package:bytebank/widgets/auth_dialog.dart';
import 'package:bytebank/widgets/response_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/matches.dart';
import '../mocks/mocks.dart';
import 'show_contacts_list.dart';

void main() {
  testWidgets("Should transfer to a contact", (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();

    final String contactName = "Marcelo Júnior";
    final int contactAccount = 1000;
    final double transferValue = 500;

    // Cria um elemento para constar na lista de contatos, uma vez
    // que no ambiente de testes, não é realizada chamada real do banco
    when(mockContactDao.all()).thenAnswer((realInvocation) async {
      return [Contact(0, contactName, contactAccount)];
    });
    await contactsListTest(tester, mockContactDao, mockTransactionWebClient);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ListItemContact) {
        return widget.contact.name == contactName &&
            widget.contact.account == contactAccount;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionFormScaffold);
    expect(transactionForm, findsOneWidget);

    final fieldContactName = find.text(contactName);
    expect(fieldContactName, findsOneWidget);

    final fieldContactAccount = find.text(contactAccount.toString());
    expect(fieldContactAccount, findsOneWidget);

    final valueTextField = textFieldMatcher("Value");
    expect(valueTextField, findsOneWidget);
    await tester.enterText(valueTextField, transferValue.toString());

    final transferButton = find.widgetWithText(RaisedButton, "Transfer");
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transferAuthDialog = find.byType(AuthDialog);
    expect(transferAuthDialog, findsOneWidget);

    final passwordTextField = find.byKey(textFieldPasswordKey);
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(passwordTextField, "1000");

    final cancelButton = find.widgetWithText(FlatButton, "Cancel");
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(FlatButton, "Confirm");
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.insert(
            Transaction(
                "", transferValue, Contact(0, contactName, contactAccount)),
            "1000"))
        .thenAnswer((_) async => Transaction(
            "", transferValue, Contact(0, contactName, contactAccount)));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccesDialog);
    expect(successDialog, findsOneWidget);
    
    final okButton = find.widgetWithText(FlatButton, "Ok");
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    expect(find.byType(ContactsListScaffold), findsOneWidget);
  });
}
