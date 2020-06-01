
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/web_client/transaction_web_client.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao{}

class MockTransactionWebClient extends Mock implements TransactionWebClient{}