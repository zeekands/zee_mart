import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/delete_product_usecase.dart';

part 'delete_product_state.dart';
part 'delete_product_cubit.freezed.dart';

@lazySingleton
class DeleteProductCubit extends Cubit<DeleteProductState> {
  final DeleteProductUsecase deleteProductUsecase;
  DeleteProductCubit(this.deleteProductUsecase) : super(const DeleteProductState.initial());

  Future<void> deleteProduct(int id) async {
    emit(const DeleteProductState.loading());

    final data = await deleteProductUsecase.execute(id);
    data.fold(
      (error) => emit(DeleteProductState.error(error)),
      (result) => emit(DeleteProductState.loaded(result)),
    );
  }
}
