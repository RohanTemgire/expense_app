import 'package:flutter/material.dart';
import './user_transactions.dart';

class NewTransaction extends StatelessWidget {
  // const NewTransaction({ Key? key }) : super(key: key);

  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  void submitData() {
    final title = titlecontroller.text;
    final amount = double.parse(amountcontroller.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    addNewTransaction(title, amount);
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
                focusColor: Colors.blue,
              ),
              // onChanged: (val) => titleinput = val,
              controller: titlecontroller,
              onSubmitted: (_) => submitData(),
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
                primary: Colors.blueAccent,
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
