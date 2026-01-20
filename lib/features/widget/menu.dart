import 'package:flutter/material.dart';
import 'package:pos_02/core/constants/set_space.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/view/view_type.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/widget/menu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const Text(
            'เมนู',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          MenuButton(
            title: 'Products',
            icon: Icons.inventory_2_sharp,
            isDanger: false,
            isSelected: false,
            onTap: () {
              context.read<ProductsBloc>().add(ProductsLoadEvent());
            },
          ),
          SizedBox(height: space.m),
          MenuButton(
            title: 'Receipts',
            icon: Icons.inventory_2_sharp,
            isDanger: false,
            isSelected: false,
            onTap: () {
              // Modular.to.navigate('/receipts');
              context.read<ReceiptsBloc>().add(LoadReceiptsEvent());
            },
          ),
          // SizedBox(height: space.m),

          // MenuButton(
          //   title: 'Products',
          //   icon: Icons.inventory_2,
          //   isSelected: selectedView == ViewType.products,
          //   onTap: () => onMenuSelected(ViewType.products),
          // ),
          // SizedBox(height: space.m),
          // MenuButton(
          //   title: 'Bills',
          //   icon: Icons.receipt_long,
          //   isSelected: selectedView == ViewType.bills,
          //   onTap: () => onMenuSelected(ViewType.bills),
          // ),
          const Spacer(),
          MenuButton(
            title: 'Logout',
            icon: Icons.logout,
            isDanger: true,
            isSelected: false,
            onTap: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
          ),
        ],
      ),
    );
  }
}
