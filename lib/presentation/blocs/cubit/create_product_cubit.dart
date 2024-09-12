import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/create_product_usecase.dart';

part 'create_product_state.dart';
part 'create_product_cubit.freezed.dart';

@lazySingleton
class CreateProductCubit extends Cubit<CreateProductState> {
  final CreateProductUsecase _createProductUsecase;
  CreateProductCubit(this._createProductUsecase) : super(CreateProductState.initial());

  void createProduct(ProductModel product) async {
    emit(const CreateProductState.loading());
    final result = await _createProductUsecase.execute(product);
    result.fold(
      (failure) => emit(CreateProductState.error(failure)),
      (product) => emit(CreateProductState.loaded(product)),
    );
  }
}
