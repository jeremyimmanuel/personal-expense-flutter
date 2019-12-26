import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TxInput extends StatelessWidget {
  final Function addTx;

  TxInput(this.addTx);

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'What did you spend on?'),
          autofocus: true,
          cursorColor: Colors.black,
          // onChanged: print,
        ),
        TextField(
          controller: amountController,
          decoration: InputDecoration(labelText: 'How much did you spend?'),
          autofocus: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FlatButton(
            child: Text('Add Transaction'),
            textColor: Colors.purple,
            onPressed: () => addTx(
              titleController.text,
              double.parse(amountController.text),
            ),
          ),
        )
      ],
    );
  }
}
