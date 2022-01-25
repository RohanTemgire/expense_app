import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transcations_list.dart';
import './widgets/chart.dart';
import './models/transactions.dart';
import './widgets/new_transactions.dart';
// import './widgets/transcations_list.dart';

void main() {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); //without this setPreferredOrientations won't work
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.landscapeRight,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double curScaleFactor = MediaQuery.of(context).textScaleFactor;  not sure about this
    // return Platform.isIOS
    //     ? CupertinoApp(
    //         title: 'Expense Application',    since there arent many opts for iso styling we would have to style them on our own
    //         theme: CupertinoThemeData(),
    //       )
    return MaterialApp(
      title: 'Expense Application',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  // fontSize: 18 * curScaleFactor,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    // fontSize: 25 * curScaleFactor,
                    fontSize: 25,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // const MyHomePage({Key? key}) : super(key: key);

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'new Shoes',
    //   amount: 2500,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 1050,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransations {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime date) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildIsLandscape(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransations),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildIsNotLandscape(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransations),
      ),
      txListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(
        context); //this is always a good practice since it impoves the performance,
    //and does not call the mediaqu again and again, instead it is stored in the variable and we can use it again and again
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expense App"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Color.fromRGBO(255, 99, 99, 1),
            title: Text("Expense App"),
            actions: <Widget>[
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          ) as PreferredSizeWidget;
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.4,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              ..._buildIsLandscape(
                mediaQuery,
                appBar as AppBar,
                txListWidget,
              ), //these 3 dots here means that the buildIsLandscape is a list, so the 3 dots extracts
//                                                 each item from the list and then passes as a single item for the widget list.
            if (!isLandscape)
              ..._buildIsNotLandscape(
                mediaQuery,
                appBar as AppBar,
                txListWidget,
              ),
            // if (!isLandscape)
            //   ..._buildIsNotLandscape(
            //     mediaQuery,
            //     appBar as AppBar,
            //     txListWidget,
            //   ),
            // if (isLandscape)
            //   ..._buildIsLandscape(
            //     mediaQuery,
            //     appBar as AppBar,
            //     txListWidget,
            //   ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
