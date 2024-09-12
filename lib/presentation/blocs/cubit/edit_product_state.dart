part of 'edit_product_cubit.dart';

@freezed
class EditProductState with _$EditProductState {
  const factory EditProductState.initial() = _Initial;
  const factory EditProductState.loading() = _Loading;
  const factory EditProductState.loaded(ProductModel product) = _Loaded;
  const factory EditProductState.error(Failure failure) = _Error;
}
