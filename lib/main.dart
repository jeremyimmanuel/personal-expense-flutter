import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expense/widgets/chart.dart';

import './models/transaction.dart';
import './widgets/txInput.dart';
import './widgets/txList.dart';
import 'models/transaction.dart';
import 'models/myTheme.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]).then((_) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: MyTheme().light,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver  {
  final List<Transaction> _userTx = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't2', title: 'Groceries', amount: 16.53, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Going out', amount: 29.99, date: DateTime.now().subtract(Duration(days: 2))),
  ];
  bool _showChart = false;

  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState(); 
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addNewTx(String title, double amount, DateTime chosenDate) {
    final tx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTx.add(tx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      _userTx.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTx {
    return _userTx.where((tx) {
      return (tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))));
    }).toList();
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: TxInput(_addNewTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  CupertinoNavigationBar _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTx(context),
          ),
        ],
      ),
    );
  }

  AppBar _buildMaterialAppBar() {
    return AppBar(
      // backgroundColor: Colors.cyan,
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTx(context),
        )
      ],
    );
  }

  List<Widget> _buildLanscapeContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
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
                  .7,
              child: Chart(_userTx),
            )
          : txList,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .3,
        child: Chart(_userTx),
      ),
      txList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    // print('build() for MyHomePage()');
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TxList(_userTx, _deleteTx),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              ..._buildLanscapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () => _startAddNewTx(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
