import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_02/features/receipts/repository/models/receipt_model.dart';
import 'package:pos_02/features/receipts/repository/services/receipts_api.dart';

part 'receipts_event.dart';
part 'receipts_state.dart';

class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  final ReceiptsApi receiptsApi;

  ReceiptsBloc({required this.receiptsApi}) : super(ReceiptsInitial()) {
    on<ReceiptsLoadEvent>(_onLoadReceits);
  }
  Future<void> _onLoadReceits(
    ReceiptsEvent event,
    Emitter<ReceiptsState> emit,
  ) async {
    emit(ReceiptsLoading());

    try {
      final receipts = await receiptsApi.getReceipts();
      emit(ReceiptsLoaded(receipts));
    } catch (e) {
      emit(ReceiptsError(message: 'โหลดข้อมูลไม่สำเร็จ : $e'));
    }
  }
}
