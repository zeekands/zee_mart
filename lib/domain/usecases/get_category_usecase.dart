import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/category_model.dart';
import 'package:zee_mart/domain/repositories/category_repository.dart';

@lazySingleton
class GetCategoryUsecase {
  final CategoryRepository _categoryRepository;

  GetCategoryUsecase(this._categoryRepository);

  Future<Either<Failure, List<CategoryModel>>> execute() {
    return _categoryRepository.getCategories();
  }
}
