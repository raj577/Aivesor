import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/stock_bloc.dart';
import 'bloc/stock_event.dart';
import 'repository/stock_repository.dart';
import 'StockHomePage.dart';

void main() {
  runApp(const StockApp());
}

class StockApp extends StatelessWidget {
  const StockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Gainers',
      home: BlocProvider(
        create: (context) => StockBloc(StockRepository())..add(FetchStocks()),
        child: const StockHomePage(),
      ),
    );
  }
}
