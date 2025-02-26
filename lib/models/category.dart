class Category {
  const Category({
    required this.categoryName,
    required this.isSelected,
  });
  final String categoryName;
  final bool isSelected;

  @override
  String toString() {
    return 'Category(categoryName: $categoryName, isSelected: $isSelected)';
  }

  Category copyWith({
    String? categoryName,
    bool? isSelected,
  }) {
    return Category(
      categoryName: categoryName ?? this.categoryName,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
