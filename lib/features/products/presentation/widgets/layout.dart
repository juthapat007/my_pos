// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/presentation/widgets/products_views.dart';
import 'package:pos_02/features/products/view/view_type.dart';
import 'menu.dart';
import 'summary.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// LEFT MENU
        Expanded(
          flex: 2,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return Menu(
                selectedView: state.viewType,
                onMenuSelected: (view) {
                  context.read<ProductsBloc>().add(ChangeViewEvent(view));
                },
              );
            },
          ),
        ),

        /// CENTER (Products or Bills)
        Expanded(
          flex: 5,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state.viewType == ViewType.products) {
                return const ProductsView();
              } else {
                return const BillsView();
              }
            },
          ),
        ),

        /// RIGHT (Cart/Summary)
        const Expanded(flex: 3, child: Summary()),
      ],
    );
  }
}