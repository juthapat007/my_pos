import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/view/products_views.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/receipts/views/receipts_view.dart';
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

                  // โหลดข้อมูล Receipts เมื่อเปลี่ยนไปหน้า Receipts
                  if (view == ViewType.receipts) {
                    context.read<ReceiptsBloc>().add(ReceiptsLoadEvent());
                  }
                },
              );
            },
          ),
        ),

        /// CENTER (Products or Receipts)
        Expanded(
          flex: 5,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              switch (state.viewType) {
                case ViewType.products:
                  return const ProductsView();
                case ViewType.receipts:
                  return const ReceiptsView();
                default:
                  return const SizedBox();
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
