import 'package:flutter/material.dart';

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

  void submitData() {
    final title = titlecontroller.text;
    final amount = double.parse(amountcontroller.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addNewTransaction(title, amount);

    Navigator.of(context).pop(); //closes the top most screen
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                focusColor: Theme.of(context).accentColor,
              ),
              // onChanged: (val) => titleinput = val,
              controller: titlecontroller,
              onSubmitted: (_) => submitData(),
            ),
            Row(
              children: <Widget>[
                Text('No date chosen.'),
                OutlinedButton(
                  child: Text('Add Date'),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (val) => amountinput = val,
              controller: amountcontroller,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
              onPressed: submitData,
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
    );
  }
}
