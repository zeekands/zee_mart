import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@lazySingleton
class DeleteProductUsecase {
  final ProductRepository _productRepository;

  DeleteProductUsecase(this._productRepository);

  Future<Either<Failure, ProductModel>> execute(int id) {
    return _productRepository.deleteProductById(id);
  }
}
