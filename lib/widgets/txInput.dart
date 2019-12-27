import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TxInput extends StatefulWidget {
  final Function addTx;

  TxInput(this.addTx);

  @override
  _TxInputState createState() => _TxInputState();
}

class _TxInputState extends State<TxInput> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    // Closes the most top widget
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
            // autofocus: true,
            cursorColor: Colors.black,
            // onSubmitted: (_) => submitData(),
            // onChanged: print,
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(hintText: 'Amount'),
            autofocus: true,
            keyboardType: TextInputType.number,
            // onSubmitted: (_) => submitData(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          )
        ],
      ),
    );
  }
}
