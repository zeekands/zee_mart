import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/get_detail_product_usecase.dart';

part 'get_detail_product_state.dart';
part 'get_detail_product_cubit.freezed.dart';

@lazySingleton
class GetDetailProductCubit extends Cubit<GetDetailProductState> {
  final GetDetailProductUsecase getDetailProductUsecase;
  GetDetailProductCubit(this.getDetailProductUsecase) : super(const GetDetailProductState.initial());

  Future<void> getDetailProduct(int id) async {
    emit(const GetDetailProductState.loading());

    final data = await getDetailProductUsecase.execute(id);
    data.fold(
      (error) => emit(GetDetailProductState.error(error)),
      (result) => emit(GetDetailProductState.loaded(result)),
    );
  }
}
