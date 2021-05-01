import 'package:flutter/cupertino.dart';
import 'package:stock_helper/models/portfolio.dart';
import 'package:stock_helper/providers/stocks.dart';

class Portfolios with ChangeNotifier {
  static List<Portfolio> _portfolios = [
    Portfolio(name: 'Technology Stocks'),
    Portfolio(name: 'Fashion Stocks'),
  ];

  Portfolios() {
    Stocks stocks = Stocks();
    for (Portfolio portfolio in _portfolios) {
      portfolio.portfolioStocks = stocks;
    }
  }

  List<Portfolio> get portfolios {
    return [..._portfolios];
  }

  void addPortfolio(Portfolio portfolio) {
    _portfolios.add(portfolio);
    notifyListeners();
  }

  void removePortfolio(Portfolio portfolio) {
    _portfolios.remove(portfolio);
    notifyListeners();
  }

  void changePortfolioName(Portfolio portfolio, String newName) {
    int portfolioIndex = _portfolios.indexWhere((element) => element == portfolio);
    _portfolios.removeAt(portfolioIndex);
    _portfolios.insert(portfolioIndex, new Portfolio(name: newName, portfolioStocks: portfolio.portfolioStocks));
    notifyListeners();
  }
}