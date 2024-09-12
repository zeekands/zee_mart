part of 'get_detail_product_cubit.dart';

@freezed
class GetDetailProductState with _$GetDetailProductState {
  const factory GetDetailProductState.initial() = _Initial;
  const factory GetDetailProductState.loading() = _Loading;
  const factory GetDetailProductState.loaded(ProductModel product) = _Loaded;
  const factory GetDetailProductState.error(Failure message) = _Error;
}
