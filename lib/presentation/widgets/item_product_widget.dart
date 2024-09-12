import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/core/utils/extentions.dart';
import 'package:zee_mart/data/models/product_model.dart';

class ItemProductWidget extends StatelessWidget {
  const ItemProductWidget({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              imageUrl: product.image,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                "assets/defaultProductImage.png",
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
                  product.categoryName,
                  maxLines: 1,
                  style: TextStyle(
                    color: kMainColor.withOpacity(.7),
                    fontSize: 12,
                  ),
                ),
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // Product Price
                Text(
                  '${product.price ?? 0}'.toCurrencyFormat(),
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
    );
  }
}
