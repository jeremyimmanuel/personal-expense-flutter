import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './txCard.dart';
import './noTx.dart';

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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        child: Text('\$${transactions[idx].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[idx].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[idx].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => delTx(transactions[idx].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => delTx(transactions[idx].id),
                        ),
                ),
              );
            },
            // children: transactions.map(buildCard).toList(),
          )
        : NoTx();
  }
}
