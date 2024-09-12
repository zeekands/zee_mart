import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@lazySingleton
class EditProductUsecase {
  final ProductRepository _productRepository;

  EditProductUsecase(this._productRepository);

  Future<Either<Failure, ProductModel>> execute(ProductModel product) async {
    return await _productRepository.updateProduct(product);
  }
}
