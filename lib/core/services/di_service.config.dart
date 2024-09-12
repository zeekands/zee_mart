// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/remote/product_remote_datasource.dart' as _i4;
import '../../data/repositories/product_repository_impl.dart' as _i6;
import '../../domain/repositories/product_repository.dart' as _i5;
import '../../domain/usecases/get_detail_product_usecase.dart' as _i7;
import '../../domain/usecases/get_product_usecase.dart' as _i8;
import '../../presentation/blocs/cubit/get_detail_product_cubit.dart' as _i10;
import '../../presentation/blocs/cubit/get_products_cubit.dart' as _i9;
import 'network_services.dart' as _i3;

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
    gh.singleton<_i3.HttpService>(() => _i3.HttpService());
    gh.factory<_i4.ProductRemoteDataSource>(
        () => _i4.ProductRemoteDataSourceImpl());
    gh.factory<_i5.ProductRepository>(() => _i6.ProductRepositoryImpl(
        productDataSource: gh<_i4.ProductRemoteDataSource>()));
    gh.lazySingleton<_i7.GetDetailProductUsecase>(
        () => _i7.GetDetailProductUsecase(gh<_i5.ProductRepository>()));
    gh.lazySingleton<_i8.GetProductUsecase>(
        () => _i8.GetProductUsecase(gh<_i5.ProductRepository>()));
    gh.factory<_i9.GetProductsCubit>(
        () => _i9.GetProductsCubit(gh<_i8.GetProductUsecase>()));
    gh.lazySingleton<_i10.GetDetailProductCubit>(
        () => _i10.GetDetailProductCubit(gh<_i7.GetDetailProductUsecase>()));
    return this;
  }
}
