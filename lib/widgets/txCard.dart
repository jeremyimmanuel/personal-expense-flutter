import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TxCard extends StatelessWidget {
  final Transaction tx;
  TxCard(this.tx);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[50],
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
            // width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(10),
            child: Text(
              "\$${tx.amount}",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: Colors.purple,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    tx.title,
                    style: TextStyle(
                        fontFamily: 'Open San',
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  DateFormat("E, MMM d'th', y").format(tx.date),
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
