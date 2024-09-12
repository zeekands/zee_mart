import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/search_product_cubit.dart';
import 'package:zee_mart/presentation/pages/product_detail_page.dart';
import 'package:zee_mart/presentation/widgets/item_product_widget.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({Key? key}) : super(key: key);

  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchProductCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        toolbarHeight: 70,
        elevation: 0,
        leadingWidth: 50,
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none, // Remove border
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                },
              ),
            ),
            onFieldSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<SearchProductCubit>().searchProduct(query);
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SearchProductCubit, SearchProductState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Enter a product to search')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                return SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      for (var product in products)
                        GestureDetector(
                          onTap: () {
                            _handleItemTap(context, product);
                          },
                          child: ItemProductWidget(size: MediaQuery.sizeOf(context), product: product),
                        ),
                    ],
                  ),
                );
              },
              error: (failure) => Center(child: Text('Error: ${failure.code}')),
            );
          },
        ),
      ),
    );
  }

  void _handleItemTap(BuildContext context, ProductModel product) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          productId: product.id.toInt(),
        ),
      ),
    )
        .then(
      (value) {
        if (value != null) {}
      },
    );
  }
}
