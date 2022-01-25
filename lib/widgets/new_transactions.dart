import 'dart:io';

import 'package:expense_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({ Key? key }) : super(key: key);

  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  var _pickedDate;

  @override
  void initState() {
    // this is usually used to load the http requests from the server before the states starts running
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // This runs at the end, when the widget is closed. this is useful to close the on going connections after the user exits the widget
    super.dispose();
  }

  void _submitData() {
    final title = titlecontroller.text;
    final amount = double.parse(amountcontroller.text);
    final date = _pickedDate;

    if (title.isEmpty || amount <= 0 || _pickedDate == null) {
      return;
    }

    widget.addNewTransaction(title, amount, date);

    Navigator.of(context).pop(); //closes the top most screen
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
    // return _pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              // CupertinoTextField()  this is mostly same as the material textField
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  focusColor: Theme.of(context).accentColor,
                ),
                // onChanged: (val) => titleinput = val,
                controller: titlecontroller,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'No Date Chosen'
                            : 'Selected Date: ${DateFormat.yMd().format(_pickedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Add Date', _presentDatePicker),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                // onChanged: (val) => amountinput = val,
                controller: amountcontroller,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: _submitData,
                // print(amountinput);
                // print(titleinput);
                // print(amountcontroller.text);
                // print(titlecontroller.text);
                // addNewTransaction(
                //   titlecontroller.text,
                //   double.parse(amountcontroller.text),
                // );
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
