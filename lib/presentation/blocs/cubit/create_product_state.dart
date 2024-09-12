part of 'create_product_cubit.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState.initial() = _Initial;
  const factory CreateProductState.loading() = _Loading;
  const factory CreateProductState.loaded(ProductModel product) = _Loaded;
  const factory CreateProductState.error(Failure failure) = _Error;
}
