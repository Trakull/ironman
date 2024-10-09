import 'package:account/main.dart';
import 'package:account/models/transactions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  final titleCtl = TextEditingController();
  final amoutCtl = TextEditingController();
  final colorCtl = TextEditingController();
  final categoryCtl = TextEditingController();
  final wattageCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มเพิ่มข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ชื่อรายการ',
                    ),
                    autofocus: false,
                    controller: titleCtl,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'จำนวนเงิน',
                    ),
                    keyboardType: TextInputType.number,
                    controller: amoutCtl,
                    validator: (String? input) {
                      try {
                        double amount = double.parse(input!);
                        if (amount < 0) {
                          return 'กรุณากรอกข้อมูลมากกว่า 0';
                        }
                      } catch (e) {
                        return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'สี',
                    ),
                    autofocus: false,
                    controller: colorCtl,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ประเภท',
                    ),
                    autofocus: false,
                    controller: categoryCtl,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'กำลังไฟ',
                    ),
                    autofocus: false,
                    controller: wattageCtl,
                  ),
                  TextButton(
                      child: const Text('บันทึก'),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // create transaction data object
                          var statement = Transactions(
                              keyID: null,
                              title: titleCtl.text,
                              amount: double.parse(amoutCtl.text),
                              date: DateTime.now());

                          // add transaction data object to provider
                          var provider = Provider.of<TransactionProvider>(
                              context,
                              listen: false);

                          provider.addTransaction(statement);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return MyHomePage();
                                  }));
                        }
                      })
                ],
              ),
            )));
  }
}
