import 'package:flutter/material.dart';
import 'package:mini_sales_dash/logic/product_provider/product_provider.dart';
import 'package:mini_sales_dash/presentation/screens/product/product_list/product_list.dart';
import 'package:mini_sales_dash/presentation/theme/default_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider()..initialize(),
      child: MaterialApp(
        title: 'Sales Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: DefaultColors.white,
        
          appBarTheme: AppBarTheme(
            backgroundColor: DefaultColors.primary,
            foregroundColor: DefaultColors.white,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          useMaterial3: true,
        ),
        home: const ProductListPage(),
      ),
    );
  }
}

