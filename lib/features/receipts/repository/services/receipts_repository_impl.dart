import 'package:pos_02/features/receipts/repository/models/receipt_model.dart';
import 'package:pos_02/features/receipts/repository/services/receipts_api.dart';
import 'package:pos_02/features/receipts/repository/services/receipts_repository.dart';
import 'package:dio/dio.dart';

class ReceiptsRepositoryImpl extends ReceiptsRepository {
  final ReceiptsApi receiptsApi;
  ReceiptsRepositoryImpl(this.receiptsApi);

  @override
  Future<List<ReceiptModel>> getReceipts() async {
    return receiptsApi.getReceipts();
  }
}
