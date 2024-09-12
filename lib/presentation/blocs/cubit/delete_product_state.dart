part of 'delete_product_cubit.dart';

@freezed
class DeleteProductState with _$DeleteProductState {
  const factory DeleteProductState.initial() = _Initial;
  const factory DeleteProductState.loading() = _Loading;
  const factory DeleteProductState.loaded(ProductModel data) = _Loaded;
  const factory DeleteProductState.error(Failure failure) = _Error;
}
