import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/core/services/di_service.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/repositories/product_repository.dart';
import 'package:zee_mart/presentation/blocs/cubit/edit_product_cubit.dart';

@LazySingleton(as: ProductRepository)
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late EditProductCubit editProductCubit;
  late MockProductRepository mockProductRepository;

  flutter_test.setUp(() {
    configureDependencies();

    mockProductRepository = MockProductRepository();
    editProductCubit = EditProductCubit(locator());
  });

  flutter_test.test('initial state is initial', () {
    flutter_test.expect(editProductCubit.state, flutter_test.equals(const EditProductState.initial()));
  });

  blocTest<EditProductCubit, EditProductState>(
    'emits [loading, loaded] when editProduct is successful',
    build: () {
      when(() => mockProductRepository.updateProduct(any())).thenAnswer(
        (_) async => Right(ProductModel(
          id: "1",
          name: 'Updated Product',
          categoryId: 1,
          categoryName: 'Category',
          sku: 'SKU',
          description: 'Updated Description',
          weight: 150.0,
          width: 15.0,
          height: 15.0,
          length: 15.0,
          image: 'updated_image_url',
          price: 150.0,
        )),
      );
      return editProductCubit;
    },
    act: (cubit) => cubit.editProduct(ProductModel(
        id: "1",
        name: 'Updated Product',
        categoryId: 1,
        categoryName: 'Category',
        sku: 'SKU',
        description: 'Updated Description',
        weight: 150.0,
        width: 15.0,
        height: 15.0,
        length: 15.0,
        image: 'updated_image_url',
        price: 150.0)),
    expect: () => [
      const EditProductState.loading(),
      EditProductState.loaded(ProductModel(
          id: "1",
          name: 'Updated Product',
          categoryId: 1,
          categoryName: 'Category',
          sku: 'SKU',
          description: 'Updated Description',
          weight: 150.0,
          width: 15.0,
          height: 15.0,
          length: 15.0,
          image: 'updated_image_url',
          price: 150.0)),
    ],
  );

  blocTest<EditProductCubit, EditProductState>(
    'emits [loading, error] when editProduct fails',
    build: () {
      when(() => mockProductRepository.updateProduct(any())).thenThrow(Exception('Failed to update product'));
      return editProductCubit;
    },
    act: (cubit) => cubit.editProduct(ProductModel(
        id: "1",
        name: 'Updated Product',
        categoryId: 1,
        categoryName: 'Category',
        sku: 'SKU',
        description: 'Updated Description',
        weight: 150.0,
        width: 15.0,
        height: 15.0,
        length: 15.0,
        image: 'updated_image_url',
        price: 150.0)),
    expect: () => [
      const EditProductState.loading(),
      const EditProductState.error(ServerFailure("message", 500)),
    ],
  );
}
