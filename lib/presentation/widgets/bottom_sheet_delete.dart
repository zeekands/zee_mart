import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/presentation/blocs/cubit/delete_product_cubit.dart';

import 'action_sheet.dart';

void showActionBottomSheet(BuildContext context, id) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Sudut melengkung di bagian atas
    ),
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: BlocConsumer<DeleteProductCubit, DeleteProductState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              error: (message) {
                Navigator.pop(context);
              },
              loaded: (approvalData) {
                Navigator.pop(context);
                Navigator.pop(context, true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted successfully', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () {
                return actionSheetContent(context, id);
              },
              loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator.adaptive())),
              error: (message) {
                return actionSheetContent(context, id);
              },
              loaded: (approvalData) {
                return actionSheetContent(context, id);
              },
            );
          },
        ),
      );
    },
  );
}
