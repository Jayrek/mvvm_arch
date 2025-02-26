import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/views/widgets/category_item_widget.dart';

import '../../models/category.dart';
import '../../viewmodels/product/product_bloc.dart';

class CategoryPanelWidget extends StatelessWidget {
  const CategoryPanelWidget({
    required this.categories,
    super.key,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.grey.shade300,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sort by:'),
            Wrap(
              children: categories.map((category) {
                return CategoryItemWidget(
                    category: category,
                    onTap: () => context.read<ProductBloc>().add(
                        FetchProductByCategory(
                            categoryType: category.categoryName)));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
