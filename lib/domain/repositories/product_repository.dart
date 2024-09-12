import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts(int page, int limit);
  Future<Either<Failure, ProductModel>> getProductById(int id);
}
