import 'package:dio/dio.dart';
import 'package:pos_02/features/receipts/repository/models/receipt_model.dart';

class ReceiptsApi {
  final Dio dio;
  ReceiptsApi(this.dio);

  //ค่อยย้อนกลับมาดูก็ได้ ถ้ามีปัญหาเรื่อง api
  Future<List<ReceiptModel>> getReceipts() async {
    final response = await dio.get('/receipts');

    final Map<String, dynamic> responseMap =
        response.data as Map<String, dynamic>;
    final ReceiptsList = responseMap['receipts'] as List;
    return ReceiptsList.map(
      (e) => ReceiptModel.fromJson(e as Map<String, dynamic>),
    ).toList();
  }
}
