part of 'search_product_cubit.dart';

@freezed
class SearchProductState with _$SearchProductState {
  const factory SearchProductState.initial() = _Initial;
  const factory SearchProductState.loading() = _Loading;
  const factory SearchProductState.loaded(List<ProductModel> products) = _Loaded;
  const factory SearchProductState.error(Failure failure) = _Error;
}
