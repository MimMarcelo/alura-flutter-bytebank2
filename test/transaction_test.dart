
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return transaction value", (){
    Transaction transaction = Transaction(null, 250, null);
    expect(transaction.value, 250);
  });

  test("Should return error when value equals or lower than 0", (){
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}
