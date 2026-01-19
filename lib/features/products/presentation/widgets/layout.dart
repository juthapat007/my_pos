// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
// import 'package:pos_02/features/products/presentation/widgets/products_views.dart';
// import 'package:pos_02/features/products/view/view_type.dart';
// import 'menu.dart';
// import 'summary.dart';

// class Layout extends StatelessWidget {
//   const Layout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         /// LEFT MENU
//         Expanded(
//           flex: 2,
//           child: BlocBuilder<ProductsBloc, ProductsState>(
//             builder: (context, state) {
//               final viewType = state is ProductsInitial
//                   ? state.viewType
//                   : ViewType.products;

//               return Menu(
//                 selectedView: viewType,
//                 onMenuSelected: (view) {
//                   context.read<ProductsBloc>().add(ChangeViewEvent(view));
//                 },
//               );
//             },
//           ),
//         ),

//         /// CENTER
//         const Expanded(flex: 5, child: ProductsView()),

//         /// RIGHT
//         const Expanded(flex: 3, child: Summary()),
//       ],
//     );
//   }
// }
