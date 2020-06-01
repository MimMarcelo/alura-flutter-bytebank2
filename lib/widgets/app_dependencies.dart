import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    @required Widget child,
    @required this.contactDao,
    @required this.transactionWebClient,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao ||
        transactionWebClient != oldWidget.transactionWebClient;
  }

  static AppDependencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }
}
