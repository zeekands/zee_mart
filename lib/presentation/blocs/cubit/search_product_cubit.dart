import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/search_product_usecase.dart';

part 'search_product_state.dart';
part 'search_product_cubit.freezed.dart';

@lazySingleton
class SearchProductCubit extends Cubit<SearchProductState> {
  final SearchProductUsecase _searchProductUsecase;
  SearchProductCubit(this._searchProductUsecase) : super(const SearchProductState.initial());

  void searchProduct(String query) async {
    emit(const SearchProductState.loading());
    final result = await _searchProductUsecase.call(query);
    result.fold(
      (failure) => emit(SearchProductState.error(failure)),
      (products) => emit(SearchProductState.loaded(products)),
    );
  }

  void clear() {
    emit(const SearchProductState.initial());
  }
}
