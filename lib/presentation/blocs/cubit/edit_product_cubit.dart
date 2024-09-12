import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/edit_product_usecase.dart';

part 'edit_product_state.dart';
part 'edit_product_cubit.freezed.dart';

@lazySingleton
class EditProductCubit extends Cubit<EditProductState> {
  final EditProductUsecase _editProductUsecase;
  EditProductCubit(this._editProductUsecase) : super(const EditProductState.initial());

  void editProduct(ProductModel product) async {
    emit(const EditProductState.loading());
    final result = await _editProductUsecase.execute(product);
    result.fold(
      (failure) => emit(EditProductState.error(failure)),
      (product) => emit(EditProductState.loaded(product)),
    );
  }
}
