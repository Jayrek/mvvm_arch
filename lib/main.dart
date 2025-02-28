import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/core/services/fake_store_service.dart';
import 'package:mvvm_arch/core/theme/app_theme.dart';
import 'package:mvvm_arch/viewmodels/product/product_bloc.dart';
import 'package:mvvm_arch/views/screens/product_detail_screen.dart';
import 'package:mvvm_arch/views/screens/product_list_screen.dart';

import 'core/constants/constant_string.dart';
import 'viewmodels/cart/cart_bloc.dart';
import 'views/screens/cart_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FakeStoreService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(fakeStoreService: context.read<FakeStoreService>())
                  ..add(const FetchProductList())
                  ..add(const FetchCategoryList()),
          ),
          BlocProvider(
            create: (context) =>
                CartBloc(fakeStoreService: context.read<FakeStoreService>())
                  ..add(const FetchCartProductList()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ConstantString.appName,
          theme: AppTheme.lightTheme,
          initialRoute: ConstantString.navigationIndex,
          routes: {
            ConstantString.navigationIndex: (context) =>
                const ProductListScreen(),
            ConstantString.navigationProductDetail: (context) =>
                const ProductDetailScreen(),
            ConstantString.navigationCartList: (context) =>
                const CartListScreen(),
          },
          // onGenerateRoute: (settings) {
          //   if (settings.name == '/productDetail') {
          //     final product = settings.arguments as Product;
          //     return MaterialPageRoute(
          //       builder: (context) => ProductDetailScreen(product: product),
          //     );
          //   }
          //   return null;
          // },
          // home: const ProductListScreen(),
        ),
      ),
    );
  }
}
