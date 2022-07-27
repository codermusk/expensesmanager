import 'package:expensemanager/widgets/Chart.dart';
import 'package:expensemanager/widgets/Transactions_list.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import '../models/Transactions.dart';
// import 'package:date_format/date_format.dart';

import 'widgets/new_transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp , DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses ',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline5: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand ',
                fontSize: 20,
              )),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> transactions = [
  final titlecontoller = TextEditingController();

  final pricecontroller = TextEditingController();

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showchart = false;

  void _addnewTransactions(
      String txTitle, double txPrice, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      price: txPrice,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  final List<Transaction> _userTransaction = [
    // Transaction(id: 'T1', title: 'Shoes', price: 859.59, date: DateTime.now()),
    // Transaction(id: 'T2', title: 'Laptop', price: 989.98, date: DateTime.now())
  ];

  void DeleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void StartAddnewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Container(
          height: 500,
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransactions(_addnewTransactions),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        'Personal Expenses',
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        IconButton(
            onPressed: () {
              StartAddnewTransactions(context);
            },
            icon: Icon(Icons.add))
      ],
    );

    final txlist = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.8,
        child: TransactionsList(_userTransaction, DeleteTransactions));
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final body = SingleChildScrollView(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('show chart'),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!islandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height) *
                      .3,
                  child: Chart(_recentTransactions)),
            if (!islandscape) txlist,
            if (islandscape)
              _showchart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height) *
                          .7,
                      child: Chart(_recentTransactions))
                  : txlist
          ]),
    );
    return  Platform.isIOS ? CupertinoPageScaffold(child: body) :Scaffold(
      appBar: appbar,
      body: body,
      // backgroundColor: Colors.grey,

      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => StartAddnewTransactions(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
