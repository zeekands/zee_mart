import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/env/env.dart';
import 'package:zee_mart/core/services/di_service.dart';
import 'package:zee_mart/core/services/network_services.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_detail_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_products_cubit.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffff6600)),
          scaffoldBackgroundColor: Colors.grey[100],
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: kMainWhite),
            actionsIconTheme: IconThemeData(color: kMainWhite),
            backgroundColor: kMainColor,
          ),
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}
