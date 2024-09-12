import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/datasources/remote/product_remote_datasource.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(int page, int limit) async {
    try {
      final products = await productDataSource.getProducts(page, limit);
      return Right(products);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    try {
      final product = await productDataSource.getProductById(id);
      return Right(product);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> deleteProductById(id) async {
    try {
      final product = await productDataSource.deleteProductById(id);
      return Right(product);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> createProduct(ProductModel product) async {
    try {
      final data = await productDataSource.createProduct(product);
      return Right(data);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> searchProduct(String query) async {
    try {
      final products = await productDataSource.searchProduct(query);
      return Right(products);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct(ProductModel product) async {
    try {
      final data = await productDataSource.updateProduct(product);
      return Right(data);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }
}
