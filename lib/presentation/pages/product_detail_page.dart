import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zee_mart/core/const/dummy_data.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_detail_product_cubit.dart';
import 'package:zee_mart/presentation/pages/edit_product_page.dart';
import 'package:zee_mart/presentation/widgets/action_button_widget.dart';
import 'package:zee_mart/presentation/widgets/bottom_sheet_delete.dart';
import 'package:zee_mart/presentation/widgets/review_section.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetDetailProductCubit>().getDetailProduct(widget.productId);
  }

  ProductModel productData = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<GetDetailProductCubit, GetDetailProductState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (product) {
              productData = product;
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (product) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  leadingWidth: 90,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      const double expandedHeight = 400.0;
                      const double collapsedHeight = 80.0;
                      final double t = ((constraints.maxHeight - collapsedHeight) / (expandedHeight - collapsedHeight))
                          .clamp(0.0, 1.0);

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: t,
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Image.asset(
                                  "assets/defaultProductImage.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 90, // Position text to the right of the leading icon
                            bottom: 16,
                            child: Opacity(
                              opacity: 1.0 - t,
                              child: Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 90 - 32),
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: kMainWhite, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                product.price.toString().toCurrencyFormat(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Weight: ${product.weight} g',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.categoryName,
                            style: TextStyle(
                              fontSize: 16,
                              color: kMainColor.withOpacity(.7),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          const Text(
                            'Dimensions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Width: ${product.width} cm\nHeight: ${product.height} cm\nLength: ${product.length} cm',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          ReviewSection(reviews: dummyReviews),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            error: (error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${error.code}'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<GetDetailProductCubit, GetDetailProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (product) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ActionButtonWidget(
                        productData: productData,
                        icon: Icons.edit,
                        label: 'Edit',
                        buttonColor: kMainColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProductPage(product: productData),
                            ),
                          ).then((value) {
                            if (value != null) {
                              context.read<GetDetailProductCubit>().getDetailProduct(productData.id.toInt());
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: ActionButtonWidget(
                      productData: productData,
                      icon: Icons.delete,
                      label: 'Delete',
                      buttonColor: kMainRed,
                      onPressed: () {
                        showActionBottomSheet(context, widget.productId);
                      },
                    )),
                  ],
                ),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
