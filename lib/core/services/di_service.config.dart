// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/remote/category_remote_datasource.dart' as _i3;
import '../../data/datasources/remote/product_remote_datasource.dart' as _i8;
import '../../data/repositories/category_repository_impl.dart' as _i5;
import '../../data/repositories/product_repository_impl.dart' as _i10;
import '../../domain/repositories/category_repository.dart' as _i4;
import '../../domain/repositories/product_repository.dart' as _i9;
import '../../domain/usecases/create_product_usecase.dart' as _i12;
import '../../domain/usecases/delete_product_usecase.dart' as _i13;
import '../../domain/usecases/edit_product_usecase.dart' as _i14;
import '../../domain/usecases/get_category_usecase.dart' as _i6;
import '../../domain/usecases/get_detail_product_usecase.dart' as _i16;
import '../../domain/usecases/get_product_usecase.dart' as _i17;
import '../../domain/usecases/search_product_usecase.dart' as _i11;
import '../../presentation/blocs/cubit/create_product_cubit.dart' as _i20;
import '../../presentation/blocs/cubit/delete_product_cubit.dart' as _i21;
import '../../presentation/blocs/cubit/edit_product_cubit.dart' as _i22;
import '../../presentation/blocs/cubit/get_category_cubit.dart' as _i15;
import '../../presentation/blocs/cubit/get_detail_product_cubit.dart' as _i23;
import '../../presentation/blocs/cubit/get_products_cubit.dart' as _i18;
import '../../presentation/blocs/cubit/search_product_cubit.dart' as _i19;
import 'network_services.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.CategoryRemoteDatasource>(
        () => _i3.CategoryRemoteDatasourceImpl());
    gh.lazySingleton<_i4.CategoryRepository>(() => _i5.CategoryRepositoryImpl(
        categoryDataSource: gh<_i3.CategoryRemoteDatasource>()));
    gh.lazySingleton<_i6.GetCategoryUsecase>(
        () => _i6.GetCategoryUsecase(gh<_i4.CategoryRepository>()));
    gh.singleton<_i7.HttpService>(() => _i7.HttpService());
    gh.factory<_i8.ProductRemoteDataSource>(
        () => _i8.ProductRemoteDataSourceImpl());
    gh.factory<_i9.ProductRepository>(() => _i10.ProductRepositoryImpl(
        productDataSource: gh<_i8.ProductRemoteDataSource>()));
    gh.lazySingleton<_i11.SearchProductUsecase>(
        () => _i11.SearchProductUsecase(gh<_i9.ProductRepository>()));
    gh.lazySingleton<_i12.CreateProductUsecase>(
        () => _i12.CreateProductUsecase(gh<_i9.ProductRepository>()));
    gh.lazySingleton<_i13.DeleteProductUsecase>(
        () => _i13.DeleteProductUsecase(gh<_i9.ProductRepository>()));
    gh.lazySingleton<_i14.EditProductUsecase>(
        () => _i14.EditProductUsecase(gh<_i9.ProductRepository>()));
    gh.lazySingleton<_i15.GetCategoryCubit>(
        () => _i15.GetCategoryCubit(gh<_i6.GetCategoryUsecase>()));
    gh.lazySingleton<_i16.GetDetailProductUsecase>(
        () => _i16.GetDetailProductUsecase(gh<_i9.ProductRepository>()));
    gh.lazySingleton<_i17.GetProductUsecase>(
        () => _i17.GetProductUsecase(gh<_i9.ProductRepository>()));
    gh.factory<_i18.GetProductsCubit>(
        () => _i18.GetProductsCubit(gh<_i17.GetProductUsecase>()));
    gh.lazySingleton<_i19.SearchProductCubit>(
        () => _i19.SearchProductCubit(gh<_i11.SearchProductUsecase>()));
    gh.lazySingleton<_i20.CreateProductCubit>(
        () => _i20.CreateProductCubit(gh<_i12.CreateProductUsecase>()));
    gh.lazySingleton<_i21.DeleteProductCubit>(
        () => _i21.DeleteProductCubit(gh<_i13.DeleteProductUsecase>()));
    gh.lazySingleton<_i22.EditProductCubit>(
        () => _i22.EditProductCubit(gh<_i14.EditProductUsecase>()));
    gh.lazySingleton<_i23.GetDetailProductCubit>(
        () => _i23.GetDetailProductCubit(gh<_i16.GetDetailProductUsecase>()));
    return this;
  }
}
