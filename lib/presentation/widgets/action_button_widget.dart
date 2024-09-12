import 'package:flutter/material.dart';
import 'package:zee_mart/data/models/product_model.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({
    super.key,
    required this.productData,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.buttonColor,
  });

  final ProductModel productData;
  final void Function() onPressed;
  final IconData icon;
  final String label;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
    );
  }
}
