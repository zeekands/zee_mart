import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@lazySingleton
class SearchProductUsecase {
  final ProductRepository _productRepository;

  SearchProductUsecase(this._productRepository);

  Future<Either<Failure, List<ProductModel>>> call(String query) async {
    return _productRepository.searchProduct(query);
  }
}
