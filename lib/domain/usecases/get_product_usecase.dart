import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@lazySingleton
class GetProductUsecase {
  final ProductRepository _productRepository;

  GetProductUsecase(this._productRepository);

  Future<Either<Failure, List<ProductModel>>> execute(int page, int limit) {
    return _productRepository.getProducts(page, limit);
  }
}
