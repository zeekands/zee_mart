import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/presentation/blocs/cubit/search_product_cubit.dart';
import 'package:zee_mart/presentation/pages/product_detail_page.dart';

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
              context.read<SearchProductCubit>().searchProduct(query);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SearchProductCubit, SearchProductState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('Enter a product to search')),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded: (products) {
                    if (products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                          subtitle: Text('${product.price}'.toCurrencyFormat(),
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: kMainColor)),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.image),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetailPage(productId: product.id.toInt())),
                            ).then((value) {
                              if (value != null) {
                                context.read<SearchProductCubit>().searchProduct(_searchController.text);
                              }
                            });
                          },
                        );
                      },
                    );
                  },
                  error: (failure) => Center(child: Text('Error: ${failure.code}')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
