import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './txCard.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;

  TxList(this.transactions);

  Widget buildCard(Transaction tx) {
    return Container(
      child: TxCard(tx),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, idx) {
          return buildCard(transactions[idx]);
        },
        // children: transactions.map(buildCard).toList(),
      ),
    );
  }
}
