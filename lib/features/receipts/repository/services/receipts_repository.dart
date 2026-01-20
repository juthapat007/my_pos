import 'package:pos_02/features/receipts/repository/models/receipt_model.dart';

abstract class ReceiptsRepository {
  Future<List<ReceiptModel>> getReceipts();
}
