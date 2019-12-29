import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chartBar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> txList;
  Chart(this.txList);

  List<Map<String, Object>> get groupTxVals {
    return List.generate(7, (idx) {
      final weekDay = DateTime.now().subtract(
        Duration(days: idx),
      );

      double totalSum = 0;

      for (var i = 0; i < txList.length; i++) {
        if (txList[i].date.day == weekDay.day &&
            txList[i].date.month == weekDay.month &&
            txList[i].date.year == weekDay.year) totalSum += txList[i].amount;
      }

      Map<String, Object> ret = {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
      return ret;
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTxVals.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTxVals.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['amount'],
              totalSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / totalSpending,
            ),
          );
        }).toList()),
      ),
    );
  }
}
