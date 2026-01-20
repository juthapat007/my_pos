class ReceiptModel {
  final int id;
  final String receiptNo;
  final double totalSummary;
  final int totalAmount;
  final DateTime createdAtThai;

  ReceiptModel({
    required this.id,
    required this.receiptNo,
    required this.totalSummary,
    required this.totalAmount,
    required this.createdAtThai,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      id: json['id'] as int,
      receiptNo: json['receipt_no'] as String,
      totalSummary: double.parse(json['total_summary'].toString()),
      totalAmount: json['total_amount'] as int,
      createdAtThai: DateTime.parse(json['created_at_thai']),
    );
  }

  /// helpers สำหรับ UI
  String get totalFormatted => totalSummary.toStringAsFixed(2);

  String get createdAtFormatted =>
      '${createdAtThai.day}/${createdAtThai.month}/${createdAtThai.year}';
}
