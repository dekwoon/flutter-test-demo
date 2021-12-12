import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_demo/database/transaction_db.dart';
import 'package:test_demo/providers/transaction_provider.dart';
import 'package:test_demo/screens/home_screen.dart';

import 'models/Transactions.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return TransactionProvider();
          })
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          home: const MyHomePage(title: 'บันทึกรายจ่าย'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = TransactionDB(dbNmae: "transaction.db");
    db.clearData(); // เคลียร์ data ก่อนใช้งาน เพื่อที่จะได้เห็นหน้าเพิ่มรายการ
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
