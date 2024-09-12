import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/services/network_services.dart';
import 'package:zee_mart/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int page, int limit);
  Future<ProductModel> getProductById(int id);
  Future<ProductModel> deleteProductById(id);
  Future<ProductModel> createProduct(ProductModel product);
  Future<List<ProductModel>> searchProduct(String query);
  Future<ProductModel> updateProduct(ProductModel product);
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

  @override
  Future<ProductModel> deleteProductById(id) {
    return apiService.delete('/products/$id').then((response) {
      return ProductModel.fromJson(response.data);
    });
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) {
    return apiService.post('/products', data: product.toJson()).then((response) {
      return ProductModel.fromJson(response.data);
    });
  }

  @override
  Future<List<ProductModel>> searchProduct(String query) {
    return apiService.get('/products?name=$query').then((response) {
      List<ProductModel> products = [];
      response.data.forEach((product) {
        products.add(ProductModel.fromJson(product));
      });
      return products;
    });
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) {
    return apiService.put('/products/${product.id}', data: product.toJson()).then((response) {
      return ProductModel.fromJson(response.data);
    });
  }
}
