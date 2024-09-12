import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_products_cubit.dart';
import 'package:zee_mart/presentation/pages/create_product_page.dart';
import 'package:zee_mart/presentation/pages/product_detail_page.dart';
import 'package:zee_mart/presentation/pages/search_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _counter = 0;
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
                  content: Text('Zee Mart created by Zeekands Technologies (Aziz Kandias)'),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<GetProductsCubit, GetProductsState>(
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
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (_, index) {
                      if (index < products.length) {
                        return GestureDetector(
                          onTap: () {
                            _handleItemTap(context, products[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: products[index].image,
                                    height: size.height * 0.19,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => CachedNetworkImage(
                                      imageUrl: "https://sudbury.legendboats.com/resource/defaultProductImage",
                                      height: size.height * 0.19,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Product Info
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Category Name
                                      Text(
                                        products[index].categoryName ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: kMainColor.withOpacity(.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      // Product Name
                                      Text(
                                        products[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Product Price
                                      Text(
                                        '${products[index].price ?? 0}'.toCurrencyFormat(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (_isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    itemCount: products.length + (_isLoadingMore ? 1 : 0),
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
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (_, index) {
                      if (index < products.length) {
                        return GestureDetector(
                          onTap: () {
                            _handleItemTap(context, products[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: products[index].image,
                                    height: size.height * 0.19,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => CachedNetworkImage(
                                      imageUrl: "https://sudbury.legendboats.com/resource/defaultProductImage",
                                      height: size.height * 0.19,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Product Info
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Category Name
                                      Text(
                                        products[index].categoryName ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: kMainColor.withOpacity(.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      // Product Name
                                      Text(
                                        products[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Product Price
                                      Text(
                                        '${products[index].price ?? 0}'.toCurrencyFormat(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (_isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    itemCount: products.length + (_isLoadingMore ? 1 : 0),
                  ),
                ),
              );
            },
          );
        },
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
