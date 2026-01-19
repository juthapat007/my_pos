import 'package:flutter/material.dart';
import 'package:pos_02/features/products/view/view_type.dart';


class Menu extends StatelessWidget {
  final ViewType selectedView;
  final ValueChanged<ViewType> onMenuSelected;

  const Menu({
    super.key,
    required this.selectedView,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MenuButton(
            title: 'สินค้า',
            isSelected: selectedView == ViewType.products,
            onTap: () => onMenuSelected(ViewType.products),
          ),
          const SizedBox(height: 12),
          _MenuButton(
            title: 'บิล',
            isSelected: selectedView == ViewType.bills,
            onTap: () => onMenuSelected(ViewType.bills),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: onTap,
      child: Text(title),
    );
  }
}
