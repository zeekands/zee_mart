import 'package:zee_mart/data/models/review_model.dart';

List<Review> dummyReviews = [
  Review(
    reviewerName: 'John Doe',
    comment: 'Great product, highly recommend!',
    rating: 4.5,
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Review(
    reviewerName: 'Jane Smith',
    comment: 'The product quality is amazing for the price.',
    rating: 5.0,
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Review(
    reviewerName: 'Alex Johnson',
    comment: 'Not bad, but the delivery was slow.',
    rating: 3.5,
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Review(
    reviewerName: 'Sarah Lee',
    comment: 'The packaging was good, and the product met my expectations.',
    rating: 4.0,
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Review(
    reviewerName: 'Michael Green',
    comment: 'The product didn’t work as expected, and customer support was unresponsive.',
    rating: 2.0,
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Review(
    reviewerName: 'Lisa Kim',
    comment: 'Fantastic! Will definitely buy again!',
    rating: 5.0,
    date: DateTime.now().subtract(const Duration(days: 6)),
  ),
  Review(
    reviewerName: 'Tom Wilson',
    comment: 'Average product. It’s okay but nothing special.',
    rating: 3.0,
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
  Review(
    reviewerName: 'Emma Watson',
    comment: 'Excellent build quality and super fast delivery!',
    rating: 4.8,
    date: DateTime.now().subtract(const Duration(days: 9)),
  ),
  Review(
    reviewerName: 'Daniel Craig',
    comment: 'I found it a bit overpriced for the features it offers.',
    rating: 3.5,
    date: DateTime.now().subtract(const Duration(days: 10)),
  ),
  Review(
    reviewerName: 'Chris Evans',
    comment: 'The product exceeded my expectations. Will definitely recommend it!',
    rating: 5.0,
    date: DateTime.now().subtract(const Duration(days: 12)),
  ),
  Review(
    reviewerName: 'Sophia Turner',
    comment: 'Good product, but it could use some improvements in packaging.',
    rating: 4.0,
    date: DateTime.now().subtract(const Duration(days: 15)),
  ),
  Review(
    reviewerName: 'David Beckham',
    comment: 'Very satisfied with the purchase. Great quality and fast delivery.',
    rating: 4.7,
    date: DateTime.now().subtract(const Duration(days: 8)),
  ),
  Review(
    reviewerName: 'Scarlett Johansson',
    comment: 'Product is decent, but delivery took too long.',
    rating: 3.8,
    date: DateTime.now().subtract(const Duration(days: 11)),
  ),
];
