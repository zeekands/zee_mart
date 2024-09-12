import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/category_model.dart';
import 'package:zee_mart/domain/usecases/get_category_usecase.dart';

part 'get_category_state.dart';
part 'get_category_cubit.freezed.dart';

@lazySingleton
class GetCategoryCubit extends Cubit<GetCategoryState> {
  final GetCategoryUsecase _getCategoryUsecase;
  GetCategoryCubit(this._getCategoryUsecase) : super(const GetCategoryState.initial());

  void getCategories() async {
    emit(const GetCategoryState.loading());
    final result = await _getCategoryUsecase.execute();
    result.fold(
      (failure) => emit(GetCategoryState.error(failure)),
      (categories) => emit(GetCategoryState.loaded(categories)),
    );
  }
}
