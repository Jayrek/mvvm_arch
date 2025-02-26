class Rating {
  const Rating({
    required this.rate,
    required this.count,
  });
  final num rate;
  final int count;

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }

  @override
  String toString() {
    return 'Rating(rate: $rate, count: $count)';
  }
}
