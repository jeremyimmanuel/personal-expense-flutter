import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './txCard.dart';
import './noTx.dart';
import './txCardList.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;

  TxList(this.transactions, this.delTx);

  Widget buildCard(Transaction tx) {
    return Container(
      child: TxCard(tx),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.length != 0
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, idx) {
              return TxCardList(transactions[idx], delTx);
            },
            // children: transactions.map(buildCard).toList(),
          )
        : NoTx();
  }
}
