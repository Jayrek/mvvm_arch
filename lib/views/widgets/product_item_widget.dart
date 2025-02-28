import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constant_string.dart';
import '../../models/product.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    required this.product,
    required this.onTap,
    this.imageHeight,
    this.imageWidth,
    this.borderColor = Colors.black87,
    this.borderWidth = 0.1,
    this.maxLines = 2,
    super.key,
  });

  final Product product;
  final Function()? onTap;
  final double? imageHeight;
  final double? imageWidth;
  final Color borderColor;
  final double borderWidth;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            side: BorderSide(width: borderWidth, color: borderColor)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: product.id,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        width: imageWidth,
                        height: imageHeight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: maxLines,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        "$dollarSign${product.price}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
