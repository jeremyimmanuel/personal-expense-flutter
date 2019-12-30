import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptiveButton.dart';

class TxInput extends StatefulWidget {
  final Function addTx;

  TxInput(this.addTx) {
    print('Constructor for TxInput Widget');
  }

  @override
  _TxInputState createState() {
    print('createState for TxInput called');
    return _TxInputState();
  }
}

class _TxInputState extends State<TxInput> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  _TxInputState(){
    // print('Constructor for TxInputState');
  }

  @override
  void initState() {
    // print('initState for TxInputState');
    super.initState();
  }

  @override
  void didUpdateWidget (TxInput oldWidget) {
    // print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // print('dispose');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    // Closes the most top widget
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
              // autofocus: true,
              cursorColor: Colors.black,
              // onSubmitted: (_) => submitData(),
              // onChanged: print,
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(hintText: 'Amount'),
              autofocus: true,
              keyboardType: TextInputType.number,
              // onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : DateFormat.yMd().format(_selectedDate)),
                  ),
                  AdaptiveFlatButton('Pick Date', _presentDatePicker),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            )
          ],
        ),
      ),
    );
  }
}
