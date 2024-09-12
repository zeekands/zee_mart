import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_products_cubit.dart';
import 'package:zee_mart/presentation/pages/create_product_page.dart';
import 'package:zee_mart/presentation/pages/product_detail_page.dart';
import 'package:zee_mart/presentation/pages/search_product_page.dart';
import 'package:zee_mart/presentation/widgets/item_product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _page = 1;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<GetProductsCubit>().getProducts(_page);
  }

  void goToCreateProduct() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (context) => const CreateProductPage()),
    )
        .then((value) {
      if (value != null) {
        _onRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: kMainColor,
              ),
              hintStyle: TextStyle(color: kMainColor),
              hintText: 'Search...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            readOnly: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchProductPage(),
                ),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('This feature is not available yet'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Zee Mart - Flutter Demo'),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<GetProductsCubit, GetProductsState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (products) {
                if (products.isEmpty) {
                  return const Center(
                    child: Text("No products available"),
                  );
                }
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (_hasMoreData &&
                          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                          !_isLoadingMore) {
                        _loadMoreData();
                        return true;
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
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
                              child: ItemProductWidget(size: size, product: product),
                            ),
                          if (_isLoadingMore)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (error) => Center(child: Text(error)),
              loadMore: (products, isLoadingMore) {
                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (_hasMoreData &&
                          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                          !_isLoadingMore) {
                        _loadMoreData();
                        return true;
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
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
                              child: ItemProductWidget(size: size, product: product),
                            ),
                          if (_isLoadingMore)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreateProduct,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _page = 1;
      _hasMoreData = true;
      _isLoadingMore = false;
    });
    await context.read<GetProductsCubit>().getProducts(_page);
  }

  void _loadMoreData() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    _page++;
    final hasMore = await context.read<GetProductsCubit>().loadMoreProducts(_page);

    setState(() {
      _hasMoreData = hasMore;
      _isLoadingMore = false;
    });

    log("Loading more: Page $_page");
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
        if (value != null) {
          _onRefresh();
        }
      },
    );
  }
}
