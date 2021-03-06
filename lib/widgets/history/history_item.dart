import 'dart:math';

import 'package:flutter/material.dart';
import '../../models/portfolio.dart';
import '../revenue_widget.dart';

class HistoryItem extends StatefulWidget {
  final Portfolio _portfolio;

  HistoryItem(this._portfolio);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  var _expanded = false;

  //tile that is always visible with the main details
  Widget mainTile() {
    return ListTile(
      title: Text(
        widget._portfolio.name,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: RevenueWidget(widget._portfolio.portfolioStocks.getRevenue(),
          MainAxisAlignment.start),
      trailing: IconButton(
        color: Colors.white,
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
      ),
    );
  }

  //widget someone when the user expands
  Widget expandedData() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: _expanded
          ? min(
              widget._portfolio.portfolioStocks.stocks.length * 30.0 + 10, 150)
          : 0,
      child: ListView(
        children: widget._portfolio.portfolioStocks.stocks
            .map(
              (stock) => Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(stock.name),
                    Text(
                      ((stock.currentPrice - stock.price) * stock.quantity)
                          .toStringAsFixed(2),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(
              widget._portfolio.portfolioStocks.stocks.length * 30.0 + 120, 260)
          : 110,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              mainTile(),
              expandedData(),
            ],
          ),
        ),
      ),
    );
  }
}
