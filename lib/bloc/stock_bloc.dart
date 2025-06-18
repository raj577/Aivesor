import 'package:flutter_bloc/flutter_bloc.dart';
import 'stock_event.dart';
import 'stock_state.dart';
import '../repository/stock_repository.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockRepository repository;

  StockBloc(this.repository) : super(StockInitial()) {
    on<FetchStocks>((event, emit) async {
      emit(StockLoading());
      try {
        final stocks = await repository.fetchTopGainers();
        emit(StockLoaded(stocks));
      } catch (e) {
        emit(StockError(e.toString()));
      }
    });
  }
}