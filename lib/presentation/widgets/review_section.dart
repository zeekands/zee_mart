import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zee_mart/data/models/review_model.dart'; // For formatting date

class ReviewSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Reviews',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListView.builder(
          shrinkWrap: true, // Ensures the list doesn't take up the entire screen
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return _buildReviewCard(review);
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review.reviewerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              _buildRatingStars(review.rating),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            review.comment,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('dd MMM yyyy').format(review.date),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  // Build the star rating widget
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16.0,
        );
      }),
    );
  }
}
