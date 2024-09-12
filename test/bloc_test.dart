import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:zee_mart/core/app_core.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/domain/usecases/create_product_usecase.dart';
import 'package:zee_mart/presentation/blocs/cubit/create_product_cubit.dart';

// Mock class for CreateProductUsecase
class MockCreateProductUsecase extends Mock implements CreateProductUsecase {
  @override
  Future<Either<Failure, ProductModel>> execute(ProductModel product) async {
    if (product.id == '1') {
      return right(product);
    } else {
      return left(const ServerFailure('Error message', 500));
    }
  }
}

void main() {
  late CreateProductCubit cubit;
  late MockCreateProductUsecase mockCreateProductUsecase;

  setUp(() {
    mockCreateProductUsecase = MockCreateProductUsecase();
    cubit = CreateProductCubit(mockCreateProductUsecase);
  });

  setUpAll(() {});

  group('CreateProductCubit', () {
    final product = ProductModel(id: '1', name: 'Product Name', price: 100.0);
    final product2 = ProductModel(id: '2', name: 'Product Name', price: 100.0);

    const failure = ServerFailure('Error message', 500);

    test('initial state is CreateProductState.initial()', () {
      expect(cubit.state, const CreateProductState.initial());
    });

    blocTest<CreateProductCubit, CreateProductState>(
      'emits [loading, loaded] when createProduct succeeds',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.createProduct(product),
      expect: () => [
        const CreateProductState.loading(),
        CreateProductState.loaded(product),
      ],
    );

    blocTest<CreateProductCubit, CreateProductState>(
      'emits [loading, error] when createProduct fails',
      build: () {
        return cubit;
      },
      act: (cubit) => cubit.createProduct(product2),
      expect: () => [
        const CreateProductState.loading(),
        const CreateProductState.error(failure),
      ],
    );
  });
}
