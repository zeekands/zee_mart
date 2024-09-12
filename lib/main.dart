import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/env/env.dart';
import 'package:zee_mart/core/services/di_service.dart';
import 'package:zee_mart/core/services/network_services.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/create_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/delete_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/edit_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_category_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_detail_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_products_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/search_product_cubit.dart';
import 'package:zee_mart/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  httpService.setBaseUrl("https://${const Env().apiSecret}.mockapi.io/api/v1");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GetProductsCubit>(
          create: (context) => GetProductsCubit(locator()),
        ),
        BlocProvider(
          create: (context) => GetDetailProductCubit(locator()),
        ),
        BlocProvider(
          create: (context) => DeleteProductCubit(locator()),
        ),
        BlocProvider(
          create: (context) => GetCategoryCubit(locator()),
        ),
        BlocProvider(
          create: (context) => CreateProductCubit(locator()),
        ),
        BlocProvider(
          create: (context) => SearchProductCubit(locator()),
        ),
        BlocProvider(
          create: (context) => EditProductCubit(locator()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffff6600)),
          scaffoldBackgroundColor: Colors.grey[100],
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: kMainWhite),
            actionsIconTheme: IconThemeData(color: kMainWhite),
            backgroundColor: kMainColor,
            titleTextStyle: TextStyle(color: kMainWhite),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              textStyle: const TextStyle(color: kMainWhite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
