import 'package:flutter/foundation.dart';
import 'package:test_demo/database/transaction_db.dart';
import 'package:test_demo/models/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  addTransaction(Transactions statement) async {
    var db = await TransactionDB(dbNmae: "transaction.db");
    await db.InsertData(statement);
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void initData() async {
    var db = await TransactionDB(dbNmae: "transaction.db");
    transactions = await db.loadAllData();
    notifyListeners();
  }
}
