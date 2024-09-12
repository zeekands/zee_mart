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
}
