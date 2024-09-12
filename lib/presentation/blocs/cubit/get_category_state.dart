part of 'get_category_cubit.dart';

@freezed
class GetCategoryState with _$GetCategoryState {
  const factory GetCategoryState.initial() = _Initial;
  const factory GetCategoryState.loading() = _Loading;
  const factory GetCategoryState.loaded(List<CategoryModel> categories) = _Loaded;
  const factory GetCategoryState.error(Failure failure) = _Error;
}
