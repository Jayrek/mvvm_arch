import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.category,
    required this.onTap,
    super.key,
  });

  final Category category;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Material(
        elevation: 4,
        color: category.isSelected ? Colors.deepOrange : null,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            side: BorderSide(width: 0.1, color: Colors.black87)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.categoryName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: category.isSelected ? Colors.white : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
