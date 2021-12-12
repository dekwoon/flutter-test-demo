import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_demo/database/transaction_db.dart';
import 'package:test_demo/models/Transactions.dart';
import 'package:test_demo/providers/transaction_provider.dart';

import 'form_screen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("รายการรายจ่าย"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FormScreen();
                      }));
                    },
                    icon: Icon(Icons.add, color: Colors.pink),
                    iconSize: 50,
                  ),
                  Text("เพิ่มรายการ",
                      style: TextStyle(fontSize: 20, color: Colors.pink)),
                ],
              ));
            } else {
              return Builder(builder: (context) {
                var items = provider.transactions;
                double sum = 0;
                for (var item in items) {
                  sum += item.amount!;
                }

                return Column(
                  children: [
                    Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      color: Colors.pink,
                      child: ListTile(
                        leading: Image.asset('asset/images/keroro_2.png'),
                        title: Text("ยอดรายจ่ายทั้งหมด",
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          NumberFormat("#,###.00", "th").format(sum),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, int index) {
                            Transactions data = provider.transactions[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              elevation: 5,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 35.0,
                                  backgroundColor: Colors.pinkAccent,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        NumberFormat("#,###.00", "th")
                                            .format(data.amount),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(data.title!),
                                subtitle: Text(DateFormat("dd/MM/yyyy")
                                        .format(data.date!) +
                                    " เวลา " +
                                    DateFormat("HH:mm").format(data.date!)),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              });
            }
          },
        ));
  }
}
