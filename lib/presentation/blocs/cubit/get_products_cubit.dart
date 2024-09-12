import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/get_product_usecase.dart';

part 'get_products_state.dart';
part 'get_products_cubit.freezed.dart';

@injectable
class GetProductsCubit extends Cubit<GetProductsState> {
  final GetProductUsecase getProductUsecase;
  static List<ProductModel> products = <ProductModel>[];
  final int iOffset = 20;
  bool _isLoadingMore = false;

  GetProductsCubit(this.getProductUsecase) : super(const GetProductsState.initial());

  Future<void> getProducts(int page) async {
    emit(const GetProductsState.loading());

    try {
      final data = await getProductUsecase.execute(page, iOffset);
      data.fold(
        (error) => emit(GetProductsState.error(error.toString())),
        (result) {
          products = result;
          emit(GetProductsState.loaded(products));
        },
      );
    } catch (e) {
      emit(GetProductsState.error(e.toString()));
    }
  }

  Future<bool> loadMoreProducts(int page) async {
    if (_isLoadingMore) return false; // Prevent concurrent load requests
    _isLoadingMore = true;
    emit(GetProductsState.loadMore(products, true));

    try {
      final result = await getProductUsecase.execute(page, iOffset);
      _isLoadingMore = false;

      return result.fold(
        (error) {
          emit(GetProductsState.error(error.toString()));
          return false; // Error, assume no more data
        },
        (newProducts) {
          if (newProducts.isNotEmpty) {
            products.addAll(newProducts);
            emit(GetProductsState.loadMore(products, false));
            return true; // More data available
          } else {
            emit(GetProductsState.loadMore(products, false));
            return false; // No more data available
          }
        },
      );
    } catch (e) {
      _isLoadingMore = false;
      emit(GetProductsState.error(e.toString()));
      return false; // Error occurred, assume no more data
    }
  }
}
