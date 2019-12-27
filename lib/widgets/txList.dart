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
      height: 500,
      child: transactions.length != 0
          ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, idx) {
                return buildCard(transactions[idx]);
              },
              // children: transactions.map(buildCard).toList(),
            )
          : Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            ),
    );
  }
}
