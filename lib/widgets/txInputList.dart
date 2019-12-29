import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './txInput.dart';
import './txList.dart';
import 'txInput.dart';

class TxInputList extends StatefulWidget {
  @override
  _TxInputListState createState() => _TxInputListState();
}

class _TxInputListState extends State<TxInputList> {
  final List<Transaction> _userTx = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 16.53,
      date: DateTime.now(),
    )
  ];

  void _addNewTx(String title, double amount) {
    final tx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _userTx.add(tx);
      print('Amount of transactions: ${_userTx.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TxInput(_addNewTx),
        // TxList(_userTx),
      ],
    );
  }
}
