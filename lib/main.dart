import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/core/services/fake_store_service.dart';
// import 'package:mvvm_arch/viewmodels/category/category_bloc.dart';
import 'package:mvvm_arch/viewmodels/product/product_bloc.dart';
import 'package:mvvm_arch/views/screens/product_detail_screen.dart';
import 'package:mvvm_arch/views/screens/product_list_screen.dart';

// import 'models/product.dart';

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
          // BlocProvider(
          //   create: (context) =>
          //       CategoryBloc(fakeStoreService: context.read<FakeStoreService>())
          //         ..add(const FetchCategory()),
          // ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FakeStoreApp',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                color: Colors.black87,
              ),
              bodySmall: TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const ProductListScreen(),
            '/productDetail': (context) => const ProductDetailScreen()
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
