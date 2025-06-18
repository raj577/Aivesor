import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../bloc/stock_event.dart';
import '../bloc/stock_state.dart';
import '../model/stock_model.dart';

class StockHomePage extends StatelessWidget {
  const StockHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Gainers"),
        centerTitle: true,
      ),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockLoaded) {
            return _buildStockList(state.stocks);
          } else if (state is StockError) {
            return Center(child: Text('❌ Error: ${state.message}'));
          } else {
            return const Center(child: Text("🔄 Press refresh to fetch data"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StockBloc>().add(FetchStocks());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildStockList(List<Stock> stocks) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(
                stock.tradingSymbol.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(stock.tradingSymbol),
            subtitle: Text("OI: ${stock.opnInterest}\nChange: ${stock.percentChange.toStringAsFixed(2)}%"),
            trailing: Text(
              "${stock.netChangeOpnInterest.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
