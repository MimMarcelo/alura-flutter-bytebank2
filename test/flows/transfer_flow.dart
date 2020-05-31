

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list_scaffold.dart';
import 'package:bytebank/screens/transaction_form_scaffold.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'show_contacts_list.dart';

void main() {
  testWidgets("Should transfer to a contact", (WidgetTester tester) async {
    final mockContactDao = MockContactDao();

    // Cria um elemento para constar na lista de contatos, uma vez
    // que no ambiente de testes, não é realizada chamada real do banco
    when(mockContactDao.all()).thenAnswer((realInvocation) async {
      return [Contact(0, "Marcelo Júnior", 1000)];
    });
    await contactsListTest(tester, mockContactDao);

    final contactItem = find.byWidgetPredicate((widget) {
      if(widget is ListItemContact){
        return widget.contact.name == "Marcelo Júnior" && widget.contact.account == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionFormScaffold);
    expect(transactionForm, findsOneWidget);
  });
}