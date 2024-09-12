import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/presentation/blocs/cubit/delete_product_cubit.dart';

Padding actionSheetContent(
  BuildContext context,
  id,
) {
  return Padding(
    padding: const EdgeInsets.all(20.0), // Padding untuk keseluruhan konten BottomSheet
    child: Column(
      mainAxisSize: MainAxisSize.min, // Menyusutkan tinggi BottomSheet sesuai konten
      children: [
        const Text(
          'Confirmation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Text('Are you sure want to delete this product?'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Logika saat tombol Cancel ditekan
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15), // Padding vertikal
                  decoration: BoxDecoration(
                    color: kMainColor, // Warna biru muda untuk Cancel
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Teks warna putih
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10), // Jarak antara tombol Cancel dan Submit
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<DeleteProductCubit>().deleteProduct(id);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15), // Padding vertikal
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(.5), // Warna biru untuk Submit
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Teks warna putih
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
