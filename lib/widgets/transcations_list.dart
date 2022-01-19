import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'There are no items to show',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/img/waiting.png',
                      fit: BoxFit.contain,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: FittedBox(
                              child: Text('₹${transactions[index].amount}')),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
