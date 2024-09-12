import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_detail_product_cubit.dart';

// class ProductDetailPage extends StatelessWidget {
//   final int productId;

//   const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     context.read<GetDetailProductCubit>().getDetailProduct(productId);

//     return Scaffold(
//       body: BlocBuilder<GetDetailProductCubit, GetDetailProductState>(
//         builder: (context, state) {
//           return state.when(
//             initial: () => const Center(child: CircularProgressIndicator()),
//             loading: () => const Center(child: CircularProgressIndicator()),
//             loaded: (product) => CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   expandedHeight: 200,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: CachedNetworkImage(
//                       imageUrl: product.image ?? '',
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) => const Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.name,
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             product.categoryName,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'Price: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(product.harga)}',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Weight: ${product.weight} g',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Description',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             product.description ?? 'No description available.',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Dimensions',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Width: ${product.width} cm\nHeight: ${product.height} cm\nLength: ${product.length} cm',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Handle Add to Cart functionality
//                             },
//                             style: ElevatedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               textStyle: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             child: const Text('Add to Cart'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                 ),
//               ],
//             ),
//             error: (error) => Center(
//               child: Text('Error: $error'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<GetDetailProductCubit>().getDetailProduct(productId);

    return Scaffold(
      body: BlocBuilder<GetDetailProductCubit, GetDetailProductState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (product) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.categoryName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(product.harga),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Weight: ${product.weight} g',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description ?? 'No description available.',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Dimensions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Width: ${product.width} cm\nHeight: ${product.height} cm\nLength: ${product.length} cm',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            error: (error) => Center(
              child: Text('Error: $error'),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  // Handle Edit functionality
                },
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  // Handle Delete functionality
                },
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
