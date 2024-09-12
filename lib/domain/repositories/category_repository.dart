import 'package:dartz/dartz.dart';
import 'package:zee_mart/core/error/failure.dart';
import 'package:zee_mart/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
