import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> data;

  ChartBar(this.data);


  @override
  Widget build(BuildContext context) {
    return Text('${data['day']}: ${data['amount']}');
  }
}