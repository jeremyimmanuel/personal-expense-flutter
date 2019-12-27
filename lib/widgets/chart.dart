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
      print(ret);
      return ret;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: 
          groupTxVals.map((data) {
            return ChartBar(data);
          }).toList()
      ),
    );
  }
}
