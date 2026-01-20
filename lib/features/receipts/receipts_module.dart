import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/receipts/repository/services/receipts_api.dart';
import 'package:pos_02/features/receipts/views/receipts_view.dart';

class ReceiptsModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<ReceiptsApi>(() => ReceiptsApi(Modular.get<Dio>()));
    i.addLazySingleton<ReceiptsBloc>(
      () => ReceiptsBloc(receiptsApi: Modular.get<ReceiptsApi>()),
    );
  }

  @override
  void routes(r) {
     r.child(
    '/',
    child:(_) => BlocProvider<ReceiptsBloc>(
      create: (_) => Modular.get<ReceiptsBloc>()..add(ReceiptsLoadEvent()),
      child: const ReceiptsView(),
    ),
     );
  }
}
