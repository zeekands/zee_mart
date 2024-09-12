import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/services/network_services.dart';
import 'package:zee_mart/data/models/category_model.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
}

@LazySingleton(as: CategoryRemoteDatasource)
class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  @override
  Future<List<CategoryModel>> getCategories() {
    final response = apiService.get('/category');
    return response.then((value) {
      final List<CategoryModel> categories = [];
      value.data.forEach((category) {
        categories.add(CategoryModel.fromJson(category));
      });
      return categories;
    });
  }
}
