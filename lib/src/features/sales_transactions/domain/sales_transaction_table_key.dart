class SalesTransactionTableKey {
  static String _tableKey = 'sales_transaction_table_key';

  static String key({String? id}) {
    if (id == null) {
      return _tableKey;
    }

    return '${_tableKey}_$id';
  }
}