import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/datasources/remote/category_remote_datasource.dart';
import 'package:zee_mart/data/models/category_model.dart';
import 'package:zee_mart/domain/repositories/category_repository.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryDataSource;

  CategoryRepositoryImpl({required this.categoryDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await categoryDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }
}
