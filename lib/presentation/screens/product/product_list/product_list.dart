import 'package:flutter/material.dart';
import 'package:mini_sales_dash/data/models/product/product_model.dart';
import 'package:mini_sales_dash/logic/product_provider/product_provider.dart';
import 'package:mini_sales_dash/presentation/screens/product/components/product_card.dart';
import 'package:mini_sales_dash/presentation/screens/product/components/product_filtered.dart';
import 'package:mini_sales_dash/presentation/screens/product/detailed/product_detailed.dart';
import 'package:mini_sales_dash/presentation/theme/default_colors.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sales Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: DefaultColors.black,
        foregroundColor: DefaultColors.white,
        elevation: 0,
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: provider.refresh,
                tooltip: 'Update',
              );
            },
          ),
        ],
      ),
      body:
      Container(
      color: DefaultColors.white,
      child:Column(
        children: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return PriceFilterWidget(
                selectedFilter: provider.selectedFilter,
                onFilterChanged: provider.changeFilter,
              );
            },
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return _buildContent(context, provider);
              },
            ),
          ),
        ],
      ),
      )
    );
  }

  Widget _buildContent(BuildContext context, ProductProvider provider) {
    switch (provider.state) {
      case ProductState.initial:
      case ProductState.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading...'),
            ],
          ),
        );

      case ProductState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: DefaultColors.errorBackground,
              ),
              const SizedBox(height: 16),
              Text(
                'Update error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                provider.error ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: TextStyle(color: DefaultColors.scaffoldBackgroundColor),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: provider.refresh,
                child: const Text('Repeat'),
              ),
            ],
          ),
        );

      case ProductState.loaded:
        if (provider.products.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: DefaultColors.scaffoldBackgroundColor,
                ),
                SizedBox(height: 16),
                Text(
                  'No products in stock',
                  style: TextStyle(fontSize: 18, color: DefaultColors.scaffoldBackgroundColor),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final product = provider.products[index];
            return ProductCard(
              product: product,
              onTap: () => _onProductTap(context, product),
            );
          },
        );
    }
  }

  void _onProductTap(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }
} 