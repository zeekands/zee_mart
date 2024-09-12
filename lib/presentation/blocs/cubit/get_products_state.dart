part of 'get_products_cubit.dart';

@freezed
class GetProductsState with _$GetProductsState {
  const factory GetProductsState.initial() = _Initial;
  const factory GetProductsState.loading() = _Loading;
  const factory GetProductsState.loaded(List<ProductModel> products) = _Loaded;
  const factory GetProductsState.loadMore(List<ProductModel> data, bool isLoadMore) = _LoadMore;
  const factory GetProductsState.error(String message) = _Error;
}
