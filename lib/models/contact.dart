
class Contact{
  final int id;
  final String name;
  final int account;

  Contact(this.id, this.name, this.account);

  @override
  String toString() {
    return 'Contact{name: $name, account: $account}';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = Map();

    contactMap['name'] = name;
    contactMap['accountNumber'] = account;
    return contactMap;
  }

  static Contact from(Map<String, dynamic> contactMap) {
    return Contact(0, contactMap['name'], contactMap['accountNumber']);
  }

  /**
   * Permite que a comparação realizada pelo Mockito possa
   * identificar que o objeto foi criado, comparando apenas
   * o nome e o número da conta
   */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          account == other.account;

  @override
  int get hashCode => name.hashCode ^ account.hashCode;
}