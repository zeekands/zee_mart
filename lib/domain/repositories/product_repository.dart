import 'package:dartz/dartz.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts(int page, int limit);
  Future<Either<Failure, ProductModel>> getProductById(int id);
  Future<Either<Failure, ProductModel>> deleteProductById(categoryId);
  Future<Either<Failure, ProductModel>> createProduct(ProductModel product);
  Future<Either<Failure, List<ProductModel>>> searchProduct(String query);
  Future<Either<Failure, ProductModel>> updateProduct(ProductModel product);
}
