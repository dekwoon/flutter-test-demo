import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:test_demo/models/Transactions.dart';
import 'package:test_demo/providers/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  // const FormScreen({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร์มบันทึกรายจ่าย"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: true,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return "กรุณากรอกชื่อรายการ";
                    }
                    return null;
                  },
                  controller: titleController,
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType: TextInputType.number,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "กรุณากรอกจำนวนเงิน"),
                    PatternValidator(r'[0-9]', errorText: "กรุณากรอกค่าตัวเลข")
                  ]),
                  controller: amountController,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var amount = amountController.text;

                            Transactions statement = Transactions(
                                title: titleController.text,
                                amount: double.parse(amountController.text),
                                date: DateTime.now());

                            TransactionProvider provider =
                                Provider.of(context, listen: false);
                            provider.addTransaction(statement);

                            Navigator.pop(context);
                          }
                        },
                        child: Text("เพิ่มข้อมูล",
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink))))
              ],
            ),
          ),
        ));
  }
}
