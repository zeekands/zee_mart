import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@lazySingleton
class CreateProductUsecase {
  final ProductRepository _productRepository;

  CreateProductUsecase(this._productRepository);

  Future<Either<Failure, ProductModel>> execute(ProductModel product) {
    return _productRepository.createProduct(product);
  }
}
