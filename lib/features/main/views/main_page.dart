// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
// import 'package:pos_02/features/widget/layout.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthUnauthenticated) {
//           Modular.to.navigate('/');
//         }
//       },
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<ProductsBloc>(
//             create: (_) =>
//                 Modular.get<ProductsBloc>()..add(ProductsLoadEvent()),
//           ),
//           BlocProvider<ReceiptsBloc>(
//             create: (_) =>
//                 Modular.get<ReceiptsBloc>()..add(LoadReceiptsEvent()),
//           ),
//         ],
//         child: const Scaffold(body: Layout()),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/widget/layout.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          print('🔓 User logged out - Navigating to /');
          Modular.to.navigate('/');
        }
      },
      child: const Scaffold(body: Layout()),
    );
  }
}
