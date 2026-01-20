import 'package:flutter/material.dart';
import 'package:pos_02/core/constants/set_space.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/view/view_type.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/widget/menu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
            isSelected: selectedView == ViewType.products,
            onTap: () {
              Modular.to.navigate('/products');
              ReadContext(
                context,
              ).read<ProductsBloc>().add(ProductsLoadEvent());
            },
          ),
          SizedBox(height: space.m),
          MenuButton(
            title: 'Receipts',
            icon: Icons.inventory_2_sharp,
            isDanger: false,
            isSelected: selectedView == ViewType.receipts,
            onTap: () {
              ReadContext(
                context,
              ).read<ReceiptsBloc>().add(ReceiptsLoadEvent());
            },
          ),
          const Spacer(),
          MenuButton(
            title: 'Logout',
            icon: Icons.logout,
            isDanger: true,
            isSelected: false,
            onTap: () {
              ReadContext(context).read<AuthBloc>().add(AuthLogout());
            },
          ),
        ],
      ),
    );
  }
}
