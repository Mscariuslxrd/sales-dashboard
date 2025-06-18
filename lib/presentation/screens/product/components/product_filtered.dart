import 'package:flutter/material.dart';
import 'package:mini_sales_dash/data/repositories/product/product_repository.dart';
import 'package:mini_sales_dash/presentation/theme/default_colors.dart';


class PriceFilterWidget extends StatelessWidget {
  final PriceFilter selectedFilter;
  final ValueChanged<PriceFilter> onFilterChanged;

  const PriceFilterWidget({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Colors.green[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Filter by price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: PriceFilter.values.map((filter) {
                final isSelected = filter == selectedFilter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildFilterButton(filter, isSelected, context),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(PriceFilter filter, bool isSelected, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [
                  DefaultColors.primary,
                  Colors.green[600]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.green[50],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? DefaultColors.primary : DefaultColors.primaryBackground,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: DefaultColors.primaryBackground,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: DefaultColors.primaryBackground,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Material(
        color: DefaultColors.transparent,
        child: InkWell(
          onTap: () => onFilterChanged(filter),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected) ...[
                  Icon(
                    Icons.check_circle,
                    color: DefaultColors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  _getFilterLabel(filter),
                  style: TextStyle(
                    color: isSelected ? DefaultColors.white : DefaultColors.primary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFilterLabel(PriceFilter filter) {
    switch (filter) {
      case PriceFilter.all:
        return 'All products';
      case PriceFilter.under100:
        return 'Less than \$100';
      case PriceFilter.between100and500:
        return '\$100 - \$500';
      case PriceFilter.over500:
        return 'Higher than \$500';
    }
  }
} 