import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/services/network_services.dart';
import 'package:zee_mart/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int page, int limit);
  Future<ProductModel> getProductById(int id);
}

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts(int page, int limit) {
    return apiService.get('/products?page=$page&limit=$limit').then((response) {
      List<ProductModel> products = [];
      response.data.forEach((product) {
        products.add(ProductModel.fromJson(product));
      });
      return products;
    });
  }

  @override
  Future<ProductModel> getProductById(int id) {
    return apiService.get('/products/$id').then((response) {
      return ProductModel.fromJson(response.data);
    });
  }
}
