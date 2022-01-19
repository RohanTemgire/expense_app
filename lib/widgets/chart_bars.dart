import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  // const ChartBars({ Key? key }) : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;

  ChartBars(this.label, this.spendingAmount, this.spendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('₹${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 70,
          width: 17,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPcOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(label),
      ],
    );
  }
}
